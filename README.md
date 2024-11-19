# SmartShell: Advanced File Analysis and Optimization

> ⚠️ **Important:** This README provides a high-level overview of the project. For comprehensive details, including architecture, design decisions, and implementation, please refer to the [Project Documentation (PDF)](./SmartShell%20Documentation.pdf).

## Overview

This repository contains **SmartShell**, a feature-rich, optimized shell script. SmartShell provides powerful tools for file analysis, user-friendly interactions, and advanced customization options. The project focuses on efficient Linux scripting techniques, optimization strategies, and creating an intuitive interface.

## Features

### Core Functionalities

-   **File Analysis**:

    -   Searches for files with specified extensions in a directory (including subdirectories).
    -   Extracts details like size, owner, permissions, and last modified timestamp.
    -   Groups files by owner and sorts groups by the total size they occupy.
-   **Report Generation**:

    -   Saves detailed analysis to `file_analysis.txt`.
    -   Generates a summary report with total file count, total size, and average file size.

### Advanced Features

-   Support for multiple file extensions in a single execution.
-   Customizable filtering options:
    -   By size (`-s`), permissions (`-p`), or timestamp (`-ts`).
-   Intuitive and user-friendly:
    -   Clear prompts and error messages.
    -   Comprehensive help section accessible via the `-h` flag.

# Usage

### Syntax

```
./script.sh <directory path> <extensions> [options]

### Options

-   `-h`: Display help information.
-   `-s`: Filter files by size (e.g., `-s +10k` for files larger than 10 KB).
-   `-p`: Filter files by permissions (e.g., `-p 755`).
-   `-ts`: Filter files by a specific timestamp.
-   `-r`: Generate a summary report.
```
### Examples

```
`# Display help
./script.sh -h

# Analyze .txt files in a directory and generate a report
./script.sh /path/to/dir txt -r

# Filter .log files by size
./script.sh /path/to/dir log -s +1M

# Analyze multiple extensions with timestamp filtering
./script.sh /path/to/dir txt log -ts 2023-01-01 -r`
```

# Future Improvements

-   Add timestamp-based filtering (e.g., files modified within the last X days).
-   Support exporting reports in CSV or JSON formats for broader usability.
-   Expand statistics in reports (e.g., file count by owner, permission summaries).

# Getting Started

To get started with **SmartShell**, clone the repository, grant execution permissions to the script, and follow the usage examples provided above.

```
`git clone <repo-url>
cd SmartShell
chmod +x script.sh`
```

## Documentation

For detailed documentation on the system's architecture, design, and implementation, please refer to the [Project Documentation (PDF)](./SmartShell%20Documentation.pdf).

Enjoy exploring your directories with **SmartShell**! 🎉
