# File Metadata Tool

A cross-platform tool for extracting and displaying file metadata, with implementations for both Windows and macOS.

## Overview

This repository contains implementations of a file metadata extraction tool:
- A Windows implementation using PowerShell for comprehensive Windows file system metadata
- (Coming soon) A macOS implementation

The tools provide detailed file system metadata in a consistent CSV format while leveraging platform-specific features for optimal performance.

## Repository Structure

```
file-metadata/
├── README.md          # This file
├── windows/          # Windows PowerShell implementation
│   ├── README.md     # Windows-specific documentation
│   └── get_file_metadata.ps1
├── macos/           # macOS implementation (coming soon)
│   ├── README.md    
│   └── get_metadata.sh
└── LICENSE
```

## Features

The Windows PowerShell implementation provides:
- Interactive folder selection via GUI
- Recursive file scanning
- Comprehensive metadata including:
  - File name, path, and extension
  - File size (in bytes and MB)
  - Creation, modification, and last access times
  - File owner and permissions
  - SHA256 hash for file integrity
  - Read-only status and file attributes
- Automatic CSV export with timestamp
- Output folder navigation
- Progress tracking during processing

## Requirements

### Windows
- Windows PowerShell 5.1 or later
- Windows 10 or later
- Administrative privileges may be required for accessing certain file metadata

### macOS
- Implementation coming soon

## Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.