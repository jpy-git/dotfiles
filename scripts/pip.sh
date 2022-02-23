#!/usr/bin/env zsh

echo "Install Python Packages"

# Upgrade install tools.
python3.10 -m pip install --upgrade pip setuptools wheel

# Install tox for environment management.
python3.10 -m pip install --upgrade tox

# Install pre-commit for pre-commit hooks.
python3.10 -m pip install --upgrade pre-commit

# Install pillow and imgcat for image viewing in the terminal.
python3.10 -m pip install --upgrade pillow imgcat

# Install boto3.
python3.10 -m pip install --upgrade boto3
