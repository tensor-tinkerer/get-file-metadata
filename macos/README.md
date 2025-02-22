# Mac File Metadata Scanner

A Bash script that recursively scans directories on macOS systems and collects comprehensive file metadata, saving the results to a CSV file. This script complements the PowerShell metadata collection script for Windows systems.

## Features

- Recursive directory scanning using native macOS commands
- Detailed metadata collection including:
  - File path and name
  - File size (in bytes and MB)
  - Creation time
  - Last modified time
  - Last accessed time
  - File owner and group
  - File permissions
  - File type (File/Directory)
  - File extension
  - MD5 hash (for files only)
- System information capture
- CSV output with detailed metadata
- Progress reporting (updates every 100 files)

## Requirements

- macOS operating system
- Bash shell (default on macOS)
- Standard macOS command-line tools

## Installation

1. Download the script to your local machine
2. Make the script executable:
   ```bash
   chmod +x get_file_metadata.sh
   ```

## Usage

Basic usage:
```bash
./get_file_metadata.sh /path/to/scan
```

Specify custom output file:
```bash
./get_file_metadata.sh /path/to/scan output_file.csv
```

## Output Format

The script generates a CSV file with the following columns:

- Path: Full path to the file/directory
- Filename: Name of the file/directory
- Size_Bytes: Size in bytes
- Size_MB: Size in megabytes
- Creation_Time: File creation timestamp
- Last_Modified: Last modification timestamp
- Last_Accessed: Last access timestamp
- Owner: File owner username
- Group: File group name
- Permissions: Unix-style permissions
- File_Type: "File" or "Directory"
- Extension: File extension (if any)
- MD5_Hash: MD5 hash of file contents (N/A for directories)

The CSV file also includes system information as a header comment.

## Performance

- Uses native macOS commands for optimal performance
- Processes files recursively using `find`
- Reports progress every 100 files
- MD5 hash calculation may impact performance for large files

## Security Note

Please be aware that this script:
- Requires read permissions for scanned directories
- Calculates MD5 hashes which may impact system performance
- Stores file metadata including paths and permissions

## Contributing

Feel free to submit issues and enhancement requests!