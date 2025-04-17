# Contributing to BASH-LIBRARY

Thank you for your interest in contributing to BASH-LIBRARY! This document provides guidelines and instructions for contributing to this project.

## Prerequisites

Before you start contributing, make sure you have the following tools and knowledge:

### Required Tools

1. **Git**
   - Basic Git knowledge
   - GitHub account
   - Understanding of branching and pull requests

2. **Shell Scripting**
   - Intermediate to advanced Bash scripting knowledge
   - Understanding of shell best practices
   - Familiarity with common Unix commands
   - Knowledge of shell function libraries

3. **Development Environment**
   - A text editor or IDE (VS Code, Vim, etc.)
   - Terminal emulator
   - Basic understanding of Linux/Unix systems

### Recommended Knowledge

1. **Shell Scripting Best Practices**
   - Function modularity and reusability
   - Error handling and logging
   - Cross-platform compatibility
   - Shell script security considerations

2. **Development Practices**
   - Version control best practices
   - Code review process
   - Testing methodologies
   - Documentation standards

### System Requirements

- **Operating System**: Linux, macOS, or Windows with WSL2
- **CPU**: 2+ cores recommended
- **RAM**: 4GB minimum
- **Storage**: 1GB free space minimum
- **Network**: Stable internet connection for Git operations

## Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct. Please be respectful and considerate of others.

## How to Contribute

### Reporting Issues

1. Check if the issue has already been reported in the [Issues](https://github.com/hperezrodal/BASH-LIBRARY/issues) section
2. If not, create a new issue with:
   - A clear, descriptive title
   - Detailed description of the problem
   - Steps to reproduce
   - Expected vs actual behavior
   - Environment details (OS, shell version, etc.)
   - Any relevant error messages or logs

### Feature Requests

1. Check if the feature has already been requested
2. Create a new issue with:
   - A clear, descriptive title
   - Detailed description of the feature
   - Use cases and benefits
   - Any relevant examples or references

### Pull Requests

1. Fork the repository
2. Create a new branch for your feature/fix:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Make your changes following the coding standards
4. Test your changes thoroughly
5. Update documentation if necessary
6. Submit a pull request with:
   - A clear description of the changes
   - Reference to any related issues
   - Examples of usage if applicable

## Development Guidelines

### Code Standards

- Follow shell script best practices:
  - Use `set -euo pipefail` in scripts
  - Quote all variables
  - Use meaningful variable names
  - Add comments for complex logic
  - Follow the existing code style
  - Use consistent indentation (2 spaces)
  - Add proper error handling
  - Include usage examples in comments

### Project Structure

1. **Modules Directory**
   - Add new functions to appropriate modules
   - Keep functions focused and single-purpose
   - Document function usage and parameters
   - Include error handling

2. **Scripts Directory**
   - Add utility scripts for common operations
   - Include proper error handling
   - Add usage documentation
   - Test thoroughly

3. **Examples Directory**
   - Add examples for new functions
   - Include various use cases
   - Document expected output
   - Test examples before committing

### Testing

1. Test your changes locally:
   - Test in different shell environments
   - Verify error handling
   - Check cross-platform compatibility
   - Test edge cases

2. Add tests for new functions:
   - Create test scripts in examples/
   - Document test cases
   - Include expected output

### Documentation

1. Update README.md for:
   - New features
   - Configuration changes
   - Usage examples
   - Breaking changes

2. Add inline comments for:
   - Function parameters
   - Return values
   - Error conditions
   - Usage examples

## Release Process

1. Version numbering follows [Semantic Versioning](https://semver.org/)
2. Create a release branch:
   ```bash
   git checkout -b release/vX.Y.Z
   ```
3. Update version numbers and changelog
4. Create a pull request for review
5. After approval, merge and tag the release

## Getting Help

- Open an issue for questions
- Join our community discussions
- Check the documentation

## License

By contributing to this project, you agree that your contributions will be licensed under the project's MIT License. 