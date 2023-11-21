#!/bin/bash

# ####################################################################################
# This script installs some common dependencies that all packages need.
# ####################################################################################

set -exo pipefail

# Update system package manager
sudo apt update -y
sudo apt upgrade -y

# Build dependencies
sudo apt install -y autoconf build-essential git libtool pkg-config shfmt wget clang-format

# CMake dependencies
sudo apt install -y cmake lcov ccache

# Doxygen dependencies
sudo apt install -y doxygen doxygen-latex doxygen-doc doxygen-gui graphviz texlive-extra-utils texlive-latex-extra

# Python dependencies, pip, venv
sudo apt install -y python3-pip python3-venv
pip install --upgrade pip setuptools

# Pre-commit, code format and check tools
sudo apt install -y cppcheck
pip install --user pre-commit cmakelang isort cpplint
