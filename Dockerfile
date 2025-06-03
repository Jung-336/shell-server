# syntax=docker/dockerfile:1

# Use an official Python runtime as the base image
FROM python:3.13-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install required packages and pipx
RUN apt-get update \
    && apt-get install --no-install-recommends -y curl python3-venv python3-pip \
    && python -m pip install --user pipx \
    && python -m pipx ensurepath \
    && apt-get remove -y curl \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add local bin to PATH where pipx installs executables
ENV PATH="/root/.local/bin:$PATH"

# Install uv using pipx
RUN pipx install uv

# Set the working directory
WORKDIR /app

# Copy only the dependencies file first to leverage Docker cache
COPY pyproject.toml ./

# Debug: verify uv is installed correctly
RUN which uv || echo "uv not found in PATH"

# Create a virtual environment using uv and install dependencies
RUN uv venv /app/.venv \
    && . /app/.venv/bin/activate \
    && uv pip install -e .

# Copy the rest of the application
COPY . .

# Expose the port the app runs on (uncomment if needed)
# EXPOSE 8000

# Command to run the application
# Use the activate script from the virtual environment before running
CMD ["/bin/bash", "-c", ". /app/.venv/bin/activate && uv run server.py"]

