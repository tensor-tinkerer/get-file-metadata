# Get the script's location
$scriptPath = $MyInvocation.MyCommand.Path
$scriptFolder = Split-Path $scriptPath -Parent

# Create a timestamp for the output file name
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$OutputFile = Join-Path $scriptFolder "FileMetadata_$timestamp.csv"

# Show folder selection dialog
Add-Type -AssemblyName System.Windows.Forms
$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$folderBrowser.Description = "Select the folder to scan"
$folderBrowser.RootFolder = [System.Environment+SpecialFolder]::Desktop

if ($folderBrowser.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
    $FolderPath = $folderBrowser.SelectedPath
} else {
    Write-Host "No folder selected. Exiting..."
    Start-Sleep -Seconds 3
    exit
}

# Verify the folder path exists
if (-not (Test-Path -Path $FolderPath -PathType Container)) {
    Write-Error "The specified folder path does not exist: $FolderPath"
    Start-Sleep -Seconds 3
    exit 1
}

Write-Host "Scanning folder: $FolderPath"
Write-Host "This may take a few minutes depending on the number of files..."

# Get files recursively
$files = Get-ChildItem -Path $FolderPath -File -Recurse

# Create an array to store file information
$fileData = foreach ($file in $files) {
    Write-Host "Processing: $($file.Name)"
    $hash = Get-FileHash -Path $file.FullName -Algorithm SHA256
    
    [PSCustomObject]@{
        'FileName' = $file.Name
        'Directory' = $file.DirectoryName
        'FullPath' = $file.FullName
        'Extension' = $file.Extension
        'SizeBytes' = $file.Length
        'SizeMB' = [math]::Round($file.Length / 1MB, 2)
        'Created' = $file.CreationTime
        'LastModified' = $file.LastWriteTime
        'LastAccessed' = $file.LastAccessTime
        'Owner' = (Get-Acl $file.FullName).Owner
        'SHA256Hash' = $hash.Hash
        'IsReadOnly' = $file.IsReadOnly
        'Attributes' = $file.Attributes
    }
}

# Export to CSV
try {
    $fileData | Export-Csv -Path $OutputFile -NoTypeInformation -Encoding UTF8
    Write-Host "`nFile metadata has been exported to: $OutputFile"
    Write-Host "Total files processed: $($fileData.Count)"
    
    # Open the output folder
    Invoke-Item (Split-Path -Parent $OutputFile)
    
    Write-Host "`nPress any key to exit..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
} catch {
    Write-Error "Failed to export data to CSV: $_"
    Start-Sleep -Seconds 5
    exit 1
}