#!/bin/bash

# https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
set -euxo pipefail

# Update and install system-level package managment dependencies
sudo apt update -y && sudo apt upgrade -y

# Build dependencies
sudo apt install -y autoconf build-essential git libtool pkg-config shfmt wget

# CMake dependencies
sudo apt install -y cmake lcov

# Doxygen dependencies
sudo apt install -y doxygen doxygen-latex doxygen-doc doxygen-gui graphviz texlive-extra-utils texlive-latex-extra

# Python dependencies
sudo apt install -y python3-pip
pip install --upgrade pip setuptools

# Code format and check tools
sudo apt install -y cppcheck &&
pip install --user pre-commit cmakelang isort cpplint
