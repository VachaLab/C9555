#!/bin/bash -l

# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh -x

# initialize uv environment
uv init .
uv venv --python 3.13.7
source .venv/bin/activate

# install packages
cp -r ../uv/pyproject.toml .
uv pip install -r pyproject.toml

# delete unnecessary files
rm -rf main.py README.md
