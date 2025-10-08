#!/bin/bash -l

# activate uv
source .venv/bin/activate

# activate jupyter
uv run --with jupyter jupyter lab --no-browser
