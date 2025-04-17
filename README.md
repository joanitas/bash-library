# BASH-LIBRARY

A comprehensive collection of reusable bash functions and scripts for common DevOps and system administration tasks, designed to make shell scripting more efficient and maintainable.

![GitHub release](https://img.shields.io/github/v/release/bash-library/bash-library?style=flat-square)
[![GitHub Issues](https://img.shields.io/github/issues/hperezrodal/bash-library)](https://github.com/hperezrodal/bash-library/issues)
[![GitHub Stars](https://img.shields.io/github/stars/hperezrodal/bash-library)](https://github.com/hperezrodal/bash-library/stargazers)
![Code Style: ShellCheck](https://img.shields.io/badge/code%20style-shellcheck-brightgreen?style=flat-square)
![Platform](https://img.shields.io/badge/platform-linux%20%7C%20macos-lightgrey?style=flat-square)
[![License](https://img.shields.io/github/license/hperezrodal/bash-library)](LICENSE)

## 🚀 Features

- Modular design for easy integration
- Reusable functions for common operations
- Well-documented code with examples
- Cross-platform compatibility
- Easy installation and setup
- Docker-based development environment
- Comprehensive DevOps tool integration

## 📋 Prerequisites

### Required Tools

- **Docker** (20.10.0 or higher)
- **Git**
- **Basic Shell Scripting knowledge**
- **Development Environment** (VS Code, Vim, etc.)

### System Requirements

- **OS**: Linux, macOS, or Windows with WSL2
- **CPU**: 2+ cores recommended
- **RAM**: 4GB minimum, 8GB recommended
- **Storage**: 10GB free space minimum
- **Network**: Stable internet connection

## 📦 Installation

### Quick Install

```bash
curl -sSL https://raw.githubusercontent.com/hperezrodal/bash-library/main/install.sh | bash
```

### Zsh Installation

If you're using zsh on macOS, you'll need to add the following to your `~/.zshrc` file:

```bash
# Add bash-library to your PATH
export PATH="$PATH:/path/to/bash-library"

# Source the library
source /path/to/bash-library/lib-loader.sh
```

After adding these lines, reload your zsh configuration:
```bash
source ~/.zshrc
```

### Manual Installation

1. Clone the repository:
```bash
git clone https://github.com/hperezrodal/bash-library.git
cd bash-library
```

2. Run the installation script:
```bash
./install.sh
```

### Uninstallation

#### System-wide Uninstallation (requires root)

```bash
sudo ./uninstall.sh
```

#### Remote Uninstallation

```bash
curl -sSL https://raw.githubusercontent.com/hperezrodal/bash-library/main/uninstall-remote.sh | bash
```

#### Zsh Uninstallation

For zsh users, remove the bash-library related lines from your `~/.zshrc` file and run:
```bash
source ~/.zshrc
```

After uninstallation, you may need to restart your shell or run `source ~/.zshrc` for changes to take effect.

## 🛠️ Project Structure

```
bash-library/
├── modules/             # Core function modules
├── scripts/             # Utility scripts
├── examples/            # Usage examples
├── lib-loader.sh        # Main functions file
├── install.sh           # Installation script
├── uninstall.sh         # Uninstallation script
├── build.sh             # Docker build script
└── CONTRIBUTING.md      # Contribution guidelines
```

## 🛠️ Usage

### Basic Usage

To use the library in your scripts, source the main functions file:

```bash
source /path/to/bash-library/lib-loader.sh
```

### Available Modules

The library provides several modules with common functions:

- **AWS Operations** (`aws.sh`): Functions for AWS-related operations

### Available Scripts

The library provides the following utility scripts:

- **AWS Secrets Management** (`aws-secrets.sh`): Script for managing AWS secrets

#### Using Scripts

After installation, scripts are automatically made available in your system's PATH. You can use them in two ways:

1. **Direct Execution**
   ```bash
   # Run the script directly
   aws-secrets --help
   ```

2. **Sourcing in Your Script**
   ```bash
   # Source the script to use its functions
   source /path/to/bash-library/scripts/aws-secrets.sh
   ```

#### Script Documentation

Each script includes built-in help documentation. To view available options and usage:
```bash
aws-secrets --help
```

### Example Usage

```bash
# Using AWS secrets script
aws-secrets get-secret my-secret-name
```

## 📚 Examples

Check out the `examples/` directory for practical usage examples of the library functions.

## Contributing

Contributions are always welcome! Please read the [contribution guidelines](CONTRIBUTING.md) first.

## License

MIT License - See [LICENSE](LICENSE) file for details

---

Made with ❤️ by [hperezrodal](https://github.com/hperezrodal) 