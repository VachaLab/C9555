#!/bin/bash -l

# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# initialize uv and add necessary packages
uv init .
uv sync
source .venv/bin/activate

# delete unnecessary files
rm -rf main.py README.md
