#!/bin/bash

# Check if a directory path was provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <directory_path> [output_file.csv]"
    exit 1
fi

# Set directory path and output file
SCAN_DIR="$1"
OUTPUT_FILE="${2:-file_metadata.csv}"

# Check if directory exists
if [ ! -d "$SCAN_DIR" ]; then
    echo "Error: Directory '$SCAN_DIR' does not exist"
    exit 1
fi

# Function to get file type
get_file_type() {
    if [ -d "$1" ]; then
        echo "Directory"
    else
        echo "File"
    fi
}

# Function to get file extension
get_extension() {
    filename=$(basename "$1")
    extension="${filename##*.}"
    if [ "$filename" = "$extension" ]; then
        echo "None"
    else
        echo "$extension"
    fi
}

# Function to convert bytes to MB
bytes_to_mb() {
    echo "scale=2; $1 / (1024 * 1024)" | bc
}

# Function to get creation time (works on Mac)
get_creation_time() {
    stat -f "%SB" "$1"
}

# Write CSV header
echo "Path,Filename,Size_Bytes,Size_MB,Creation_Time,Last_Modified,Last_Accessed,Owner,Group,Permissions,File_Type,Extension,MD5_Hash" > "$OUTPUT_FILE"

# Write system information as a comment
echo "# System Information:" >> "$OUTPUT_FILE"
echo "# OS: $(uname -s)" >> "$OUTPUT_FILE"
echo "# Release: $(uname -r)" >> "$OUTPUT_FILE"
echo "# Version: $(sw_vers -productVersion)" >> "$OUTPUT_FILE"
echo "# Machine: $(uname -m)" >> "$OUTPUT_FILE"

# Start time
start_time=$(date +%s)

# Counter for progress
file_count=0

# Function to process each file
process_file() {
    local file="$1"
    
    # Get basic file information
    local filename=$(basename "$file")
    local size_bytes=$(stat -f "%z" "$file")
    local size_mb=$(bytes_to_mb $size_bytes)
    local creation_time=$(get_creation_time "$file")
    local modified_time=$(stat -f "%Sm" "$file")
    local access_time=$(stat -f "%Sa" "$file")
    local owner=$(stat -f "%Su" "$file")
    local group=$(stat -f "%Sg" "$file")
    local perms=$(stat -f "%Lp" "$file")
    local file_type=$(get_file_type "$file")
    local extension=$(get_extension "$file")
    
    # Calculate MD5 hash for files only
    local md5hash
    if [ "$file_type" = "File" ]; then
        md5hash=$(md5 -q "$file")
    else
        md5hash="N/A"
    fi
    
    # Write to CSV, properly escaping commas in the path
    echo "\"$file\",\"$filename\",$size_bytes,$size_mb,\"$creation_time\",\"$modified_time\",\"$access_time\",\"$owner\",\"$group\",$perms,\"$file_type\",\"$extension\",\"$md5hash\"" >> "$OUTPUT_FILE"
    
    # Increment counter and show progress
    ((file_count++))
    if [ $((file_count % 100)) -eq 0 ]; then
        echo "Processed $file_count files..."
    fi
}

# Export the function so it's available to find
export -f process_file
export OUTPUT_FILE
export -f get_file_type
export -f get_extension
export -f bytes_to_mb
export -f get_creation_time

echo "Starting scan of $SCAN_DIR..."

# Use find to recursively process all files and directories
find "$SCAN_DIR" -print0 | while IFS= read -r -d $'\0' file; do
    process_file "$file"
done

# Calculate and display execution time
end_time=$(date +%s)
duration=$((end_time - start_time))

echo "Scan completed in $duration seconds"
echo "Total files processed: $file_count"
echo "Results saved to $OUTPUT_FILE"