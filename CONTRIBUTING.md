# Contributing to SwiftGlass

Thank you for your interest in contributing to SwiftGlass! We welcome contributions from everyone, regardless of experience level.

## Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Commit Guidelines](#commit-guidelines)
- [Testing](#testing)
- [Documentation](#documentation)
- [Issue Reporting](#issue-reporting)
- [Community](#community)

## Code of Conduct

Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project, you agree to abide by its terms.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone** your fork locally:
   ```
   git clone https://github.com/YOUR-USERNAME/swiftglass.git
   cd swiftglass
   ```
3. **Set up the remote upstream**:
   ```
   git remote add upstream https://github.com/1998code/swiftglass.git
   ```
4. **Create a branch** for your work:
   ```
   git checkout -b your-feature-name
   ```

## Development Setup

Follow these steps to set up your development environment:

1. **Requirements:**
   - Xcode 15.0 or later
   - Swift 5.9 or later
   - macOS 14.0 or later

2. **Open the Package:**
   ```
   open Package.swift
   ```
   Or open the package directly in Xcode by double-clicking the Package.swift file

3. **Build the Package:**
   - In Xcode, select Product > Build to build the package
   - Alternatively, use the command line:
   ```
   swift build
   ```

<!-- 4. **Run Tests:**
   - In Xcode, select Product > Test to run tests
   - Alternatively, use the command line:
   ```
   swift test
   ``` -->

## Pull Request Process

1. **Update your fork** with the latest changes from the upstream repository:
   ```
   git fetch upstream
   git merge upstream/main
   ```
2. **Commit** your changes with clear commit messages
3. **Push** to your fork:
   ```
   git push origin your-feature-name
   ```
4. **Submit a Pull Request** through the GitHub interface
5. **Respond to feedback** and make requested changes if needed
6. Once approved, your PR will be merged by a maintainer

## Coding Standards

Please follow these guidelines when writing code:

- Use consistent indentation
- Follow naming conventions for variables, functions, and classes
- Write clear comments for complex code sections
- Break large functions into smaller, more manageable ones
- Remove any debugging code or console logs before submitting
- Format your code using the project's linter configuration

## Commit Guidelines

We follow conventional commits for our commit messages:

Example: `Add new examples`

## Testing

Before submitting your PR, ensure:

1. All existing tests pass
2. You've added tests for new functionality
3. Your changes don't break existing functionality

## Documentation

Please update documentation when:

- Adding new features
- Changing existing functionality
- Fixing bugs that affect user experience
- Updating dependencies or configuration

## Issue Reporting

When reporting issues, please include:

1. A clear, descriptive title
2. Steps to reproduce the issue
3. Expected behavior
4. Actual behavior
5. Screenshots if applicable
6. Environment information (OS, Xcode Version, etc.)

## Community

- Star our repository on [GitHub](https://github.com/1998code/swiftglass)
- Follow [1998code](https://github.com/1998code) for updates
- Report issues and suggest features through [GitHub Issues](https://github.com/1998code/swiftglass/issues)

Thank you for contributing to SwiftGlass! Your help makes this project better for everyone.
