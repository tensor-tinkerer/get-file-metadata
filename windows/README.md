# Windows File Metadata Tool

A PowerShell script for extracting comprehensive file metadata from Windows file systems.

## Features

- Interactive folder selection using Windows Forms dialog
- Recursive scanning of all files in selected directory
- Comprehensive metadata extraction including:
  - Basic file information (name, directory, full path, extension)
  - File sizes (in bytes and MB)
  - Timestamps (creation, modification, last access)
  - File ownership information
  - SHA256 hash for file integrity verification
  - File attributes and read-only status
- Automatic CSV export with timestamp-based naming
- Progress tracking for each file being processed
- Automatic opening of output folder upon completion

## Requirements

- Windows PowerShell 5.1 or later
- Windows 10 or later
- Administrative privileges may be required for accessing certain file metadata

## Installation

1. Download `get_file_metadata.ps1` from this repository
2. Save it to your desired location
3. Ensure PowerShell execution policy allows running scripts:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

## Usage

1. Double-click the script or run it from PowerShell
2. Select the target folder using the GUI dialog
3. Wait for the script to process all files
4. The output CSV will automatically open in your default file explorer

### Output Format

The script generates a CSV file with the following columns:
- FileName: Name of the file
- Directory: Parent directory path
- FullPath: Complete file path
- Extension: File extension
- SizeBytes: File size in bytes
- SizeMB: File size in megabytes (rounded to 2 decimal places)
- Created: File creation timestamp
- LastModified: Last modification timestamp
- LastAccessed: Last access timestamp
- Owner: File owner
- SHA256Hash: SHA256 hash of the file contents
- IsReadOnly: Boolean indicating read-only status
- Attributes: File system attributes

### Output Location

The CSV file is saved in the same directory as the script with the naming format:
```
FileMetadata_yyyy-MM-dd_HH-mm-ss.csv
```

## Error Handling

The script includes error handling for:
- Invalid folder selection
- Non-existent folders
- CSV export failures

## Contributing

Feel free to submit issues and enhancement requests.