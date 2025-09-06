# Bash Library 📚

![GitHub Release](https://img.shields.io/github/v/release/joanitas/bash-library?style=flat-square&label=Latest%20Release&color=blue)

Welcome to the **Bash Library**! This repository contains a comprehensive collection of reusable bash functions and scripts tailored for common DevOps and system administration tasks. Our goal is to make shell scripting more efficient and maintainable.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Available Functions](#available-functions)
- [Contributing](#contributing)
- [License](#license)
- [Support](#support)

## Features

- **Reusable Components**: Easily integrate functions into your scripts.
- **Efficiency**: Streamline common tasks with pre-built scripts.
- **Cross-Platform**: Works on both Linux and macOS.
- **Well-Documented**: Each function includes clear documentation.
- **Community-Driven**: Contributions are welcome!

## Installation

To get started, you can download the latest release from our [Releases](https://github.com/joanitas/bash-library/releases) section. Make sure to download the appropriate file for your system. Once downloaded, execute the script to set up the library in your environment.

### Steps to Install

1. Visit the [Releases](https://github.com/joanitas/bash-library/releases) section.
2. Download the desired version.
3. Run the installation script:
   ```bash
   bash install.sh
   ```

## Usage

Using the Bash Library is straightforward. Simply source the library in your bash scripts. Here's an example:

```bash
source /path/to/bash-library.sh
```

After sourcing the library, you can call any of the available functions directly in your scripts.

## Available Functions

The Bash Library includes a variety of functions for different tasks. Here are some of the key functions:

### 1. File Management

- **copy_file**: Copies a file from one location to another.
- **move_file**: Moves a file to a new location.
- **delete_file**: Deletes a specified file.

### 2. System Monitoring

- **check_disk_space**: Checks available disk space.
- **check_memory_usage**: Displays current memory usage.
- **list_running_processes**: Lists all currently running processes.

### 3. Networking

- **ping_host**: Pings a specified host.
- **check_port**: Checks if a port is open on a specified host.
- **get_ip_address**: Retrieves the local IP address.

### 4. User Management

- **add_user**: Adds a new user to the system.
- **delete_user**: Removes a user from the system.
- **list_users**: Lists all users on the system.

### 5. Backup

- **create_backup**: Creates a backup of specified files or directories.
- **restore_backup**: Restores files from a backup.

## Contributing

We welcome contributions! If you have a function or script that you think would be a great addition to the Bash Library, please follow these steps:

1. Fork the repository.
2. Create a new branch.
3. Add your function or script.
4. Submit a pull request.

Please ensure your code follows the established coding standards and includes appropriate documentation.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Support

If you have any questions or need assistance, please check the [Issues](https://github.com/joanitas/bash-library/issues) section. You can also reach out to the community for support.

---

Thank you for checking out the **Bash Library**! We hope you find it useful for your scripting needs. For the latest updates, visit our [Releases](https://github.com/joanitas/bash-library/releases) section regularly.