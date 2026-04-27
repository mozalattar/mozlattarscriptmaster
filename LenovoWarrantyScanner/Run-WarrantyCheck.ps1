# Lenovo Bulk Warranty Check
# Requires: Install-Script -Name Get-LenovoInfo  (run once as Admin)
#
# Usage:
#   .\Run-WarrantyCheck.ps1
#
# Output: warranty_results.csv in the same folder

$SerialsFile = "$PSScriptRoot\serials.txt"
$OutputFile  = "$PSScriptRoot\warranty_results.csv"

# Check Get-LenovoInfo is installed
if (-not (Get-Command Get-LenovoInfo -ErrorAction SilentlyContinue)) {
    Write-Host "Get-LenovoInfo is not installed. Installing now..." -ForegroundColor Yellow
    Install-Script -Name Get-LenovoInfo -Force
    Write-Host "Installed." -ForegroundColor Green
}

# Load serials
$serials = Get-Content $SerialsFile | Where-Object { $_.Trim() -ne "" } | ForEach-Object { $_.Trim().ToUpper() }
$total   = $serials.Count
Write-Host ""
Write-Host "Loaded $total serials from serials.txt" -ForegroundColor Cyan
Write-Host ""

# Run checks
$results = [System.Collections.Generic.List[PSCustomObject]]::new()
$idx = 0

foreach ($sn in $serials) {
    $idx++
    Write-Progress -Activity "Lenovo Warranty Check" `
                   -Status "[$idx / $total]  $sn" `
                   -PercentComplete (($idx / $total) * 100)

    try {
        $info = Get-LenovoInfo -Serialnumber $sn -Brief -ErrorAction Stop

        # Cast DaysLeft to int for correct numeric sort, pick best warranty row
        $best = $info | Sort-Object { [int]$_.DaysLeft } -Descending | Select-Object -First 1

        # Year Purchased: current year minus YearsSinceBought (rounded)
        $yearPurchased = (Get-Date).Year - [math]::Round([double]$best.YearsSinceBought)

        # Laptop Age (Yrs): YearsSinceBought rounded to 1 decimal
        $laptopAge = [math]::Round([double]$best.YearsSinceBought, 1)

        $results.Add([PSCustomObject]@{
            Serial          = $sn
            ProductName     = $best.ProductName
            Model           = $best.Model
            WarrantyName    = $best.Name
            Status          = $best.Status
            'Laptop Age (Yrs)' = $laptopAge
            'Year Purchased'   = $yearPurchased
            DeliveryType    = $best.DeliveryType
            Error           = ""
        })

        $color = if ($best.Status -eq "Active")      { "Green" }
                 elseif ($best.Status -eq "Expired")  { "Red" }
                 else { "Yellow" }

        Write-Host ("  [{0,3}/{1}]  {2,-12}  {3,-10}  Age: {4} yrs  Purchased: {5}  {6}" -f `
            $idx, $total, $sn, $best.Status, $laptopAge, $yearPurchased, $best.ProductName) `
            -ForegroundColor $color

    } catch {
        $results.Add([PSCustomObject]@{
            Serial             = $sn
            ProductName        = "N/A"
            Model              = "N/A"
            WarrantyName       = "N/A"
            Status             = "ERROR"
            'Laptop Age (Yrs)' = "N/A"
            'Year Purchased'   = "N/A"
            DeliveryType       = "N/A"
            Error              = $_.Exception.Message
        })
        Write-Host ("  [{0,3}/{1}]  {2,-12}  ERROR: {3}" -f $idx, $total, $sn, $_.Exception.Message) -ForegroundColor Yellow
    }
}

# Export
$results | Export-Csv -Path $OutputFile -NoTypeInformation -Encoding UTF8

# Summary
$active  = @($results | Where-Object { $_.Status -eq "Active"  }).Count
$expired = @($results | Where-Object { $_.Status -eq "Expired" }).Count
$errors  = @($results | Where-Object { $_.Status -eq "ERROR"   }).Count

Write-Host ""
Write-Host "Saved to: $OutputFile" -ForegroundColor Green
Write-Host ""
Write-Host "Summary" -ForegroundColor Cyan
Write-Host "  Total    : $total"
Write-Host "  Active   : $active"   -ForegroundColor Green
Write-Host "  Expired  : $expired"  -ForegroundColor Red
Write-Host "  Errors   : $errors"   -ForegroundColor Yellow
Write-Host ""
