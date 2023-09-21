# Import the ShareGate module
Import-Module ShareGate

# Set ShareGate credentials
$sourceCredential = Get-Credential -Message "Enter credentials for the source SharePoint 2019 site"
$targetCredential = Get-Credential -Message "Enter credentials for the target SharePoint Online site"

# Define the CSV file path
$csvPath = "C:\path\to\your\migration\file.csv"

# Read the CSV file
$csvData = Import-Csv -Path $csvPath

# Loop through each row in the CSV
foreach ($row in $csvData) {
    $sourceSiteUrl = $row.SourceSiteUrl
    $targetSiteUrl = $row.TargetSiteUrl
    $migrationType = $row.MigrationType

    # Perform migration based on the specified type (Incremental or Full)
    if ($migrationType -eq "Incremental") {
        Write-Host "Performing Incremental migration from $sourceSiteUrl to $targetSiteUrl"
        # Use ShareGate cmdlet for Incremental migration
        Start-SPOSiteMigration -Credential $sourceCredential -SourceSiteUrl $sourceSiteUrl -TargetSiteUrl $targetSiteUrl -Incremental -Verbose
    } elseif ($migrationType -eq "Full") {
        Write-Host "Performing Full migration from $sourceSiteUrl to $targetSiteUrl"
        # Use ShareGate cmdlet for Full migration
        Start-SPOSiteMigration -Credential $sourceCredential -SourceSiteUrl $sourceSiteUrl -TargetSiteUrl $targetSiteUrl -Full -Verbose
    } else {
        Write-Host "Invalid migration type specified for row: Source: $sourceSiteUrl, Target: $targetSiteUrl"
    }
}
