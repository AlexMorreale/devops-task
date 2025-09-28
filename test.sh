#!/bin/bash

# Check if we're in a container (no .venv) or local dev (with .venv)
if [ -d ".venv" ]; then
    # Local development - use virtual environment
    source .venv/bin/activate
fi

# Run tests (works in both container and local environments)
python -m unittest helloapp.test