# ============================================================
# MASTER TERRAFORM DEPLOYMENT SCRIPT
# Architecture: VPC + Launch Template + Target Group
#              + ACM + ALB + Auto Scaling Group
#
# Usage:
#   .\prod-arch-deploy.ps1 apply
#   .\prod-arch-deploy.ps1 destroy
# ============================================================

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet("apply", "destroy")]
    [string]$Action
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ------------------------------------------------------------
# CONFIGURATION
# ------------------------------------------------------------

# This script is located in environments\compute.
$RootDir = $PSScriptRoot

# Wait between modules for AWS resources and dependencies.
$WaitSeconds = 20

# Resolve all module paths relative to environments\compute.
# Keep these paths consistent with your actual folder structure.
$Modules = [ordered]@{
    VPC = "..\network\vpc\dev"
    LT  = "lt\dev"
    TG  = "tg\dev"
    ACM = "acm-alb"
    ALB = "alb\dev"
    ASG = "asg\dev"
}

# ------------------------------------------------------------
# LOGGING
# ------------------------------------------------------------

function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "[SUCCESS] $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

function Write-Failure {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

# ------------------------------------------------------------
# TERRAFORM COMMAND WRAPPER
# ------------------------------------------------------------

function Invoke-Terraform {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    & terraform @Arguments

    if ($LASTEXITCODE -ne 0) {
        throw "Terraform failed: terraform $($Arguments -join ' ') (exit code $LASTEXITCODE)"
    }
}

# ------------------------------------------------------------
# MODULE EXECUTION
# ------------------------------------------------------------

function Invoke-TerraformModule {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ModuleName,

        [Parameter(Mandatory = $true)]
        [string]$ModulePath,

        [Parameter(Mandatory = $true)]
        [ValidateSet("apply", "destroy")]
        [string]$Operation
    )

    # Build the absolute path from this script's directory.
    $CandidatePath = Join-Path $RootDir $ModulePath

    if (-not (Test-Path -LiteralPath $CandidatePath -PathType Container)) {
        throw "Module directory not found: $CandidatePath"
    }

    $FullPath = (Resolve-Path -LiteralPath $CandidatePath).Path

    # A module must contain Terraform configuration.
    $TerraformFiles = @(
        Get-ChildItem -LiteralPath $FullPath -File |
            Where-Object { $_.Extension -eq ".tf" }
    )

    if ($TerraformFiles.Count -eq 0) {
        throw "No .tf files found in module directory: $FullPath"
    }

    Write-Host ""
    Write-Host "============================================================" `
        -ForegroundColor DarkCyan
    Write-Host "$Operation : $ModuleName" -ForegroundColor Magenta
    Write-Host "Directory: $FullPath" -ForegroundColor Gray
    Write-Host "============================================================" `
        -ForegroundColor DarkCyan

    Push-Location $FullPath

    try {
        Write-Info "Initializing Terraform for $ModuleName..."

        Invoke-Terraform -Arguments @("init", "-input=false")

        if ($Operation -eq "apply") {
            Write-Info "Validating Terraform configuration..."

            Invoke-Terraform -Arguments @("validate")

            Write-Info "Planning $ModuleName..."

            Invoke-Terraform -Arguments @(
                "plan",
                "-input=false",
                "-out=tfplan"
            )

            Write-Info "Applying $ModuleName..."

            Invoke-Terraform -Arguments @(
                "apply",
                "-input=false",
                "-auto-approve",
                "tfplan"
            )
        }
        else {
            Write-Warning "Destroying resources in $ModuleName..."

            Invoke-Terraform -Arguments @(
                "destroy",
                "-input=false",
                "-auto-approve"
            )
        }

        Write-Success "$ModuleName completed successfully."
    }
    finally {
        Pop-Location
    }

    # Wait only after successful module completion.
    if ($WaitSeconds -gt 0) {
        Write-Warning "Waiting $WaitSeconds seconds before the next module..."
        Start-Sleep -Seconds $WaitSeconds
    }
}

# ------------------------------------------------------------
# APPLY: FORWARD DEPENDENCY ORDER
# ------------------------------------------------------------

function Invoke-Apply {
    Write-Host ""
    Write-Info "Starting AWS infrastructure deployment..."

    $ApplyOrder = @(
        @{ Name = "VPC / Network"; Key = "VPC" },
        @{ Name = "Launch Template"; Key = "LT" },
        @{ Name = "Target Group"; Key = "TG" },
        @{ Name = "ACM Certificate"; Key = "ACM" },
        @{ Name = "Application Load Balancer"; Key = "ALB" },
        @{ Name = "Auto Scaling Group"; Key = "ASG" }
    )

    foreach ($Module in $ApplyOrder) {
        Invoke-TerraformModule `
            -ModuleName $Module.Name `
            -ModulePath $Modules[$Module.Key] `
            -Operation "apply"
    }

    Write-Host ""
    Write-Success "ALL MODULES APPLIED SUCCESSFULLY!"
}

# ------------------------------------------------------------
# DESTROY: REVERSE DEPENDENCY ORDER
# ------------------------------------------------------------

function Invoke-Destroy {
    Write-Host ""
    Write-Warning "Starting AWS infrastructure destruction."
    Write-Warning "exiModules will be destroyed in reverse dependency order."

    $DestroyOrder = @(
        @{ Name = "Auto Scaling Group"; Key = "ASG" },
        @{ Name = "Application Load Balancer"; Key = "ALB" },
        @{ Name = "Target Group"; Key = "TG" },
        @{ Name = "ACM Certificate"; Key = "ACM" },
        @{ Name = "Launch Template"; Key = "LT" },
        @{ Name = "VPC / Network"; Key = "VPC" }
    )

    foreach ($Module in $DestroyOrder) {
        Invoke-TerraformModule `
            -ModuleName $Module.Name `
            -ModulePath $Modules[$Module.Key] `
            -Operation "destroy"
    }

    Write-Host ""
    Write-Success "ALL MODULES DESTROYED SUCCESSFULLY!"
}

# ------------------------------------------------------------
# MAIN
# ------------------------------------------------------------

try {
    # Ensure Terraform is installed and available in PATH.
    if (-not (Get-Command terraform -ErrorAction SilentlyContinue)) {
        throw "Terraform was not found in PATH. Install Terraform or fix PATH."
    }

    switch ($Action) {
        "apply"   { Invoke-Apply }
        "destroy" { Invoke-Destroy }
    }
}
catch {
    Write-Failure $_.Exception.Message
    Write-Warning "Execution stopped. Fix the failed module before continuing."
    exit 1
}