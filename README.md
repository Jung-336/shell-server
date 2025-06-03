# Terminal Command MCP Server

A simple MCP (Model Context Protocol) server that provides a tool for executing terminal commands.

## Overview

This server implements the MCP protocol to expose a single tool:
- `run_command`: Executes a terminal command and returns the output

## Installation

1. Make sure you have Python 3.8+ installed
2. Install dependencies:

```bash
pip install -r requirements.txt
```

## Usage

### Starting the Server

Run the server with:

```bash
python server.py
```

The server will start on `http://0.0.0.0:8000`

### API Endpoints

- `GET /`: Server information
- `GET /tools`: List of available tools
- `POST /tools/run_command`: Execute a terminal command

### Example Request

```bash
curl -X POST http://localhost:8000/tools/run_command \
  -H "Content-Type: application/json" \
  -d '{"command": "echo Hello World", "cwd": "/path/to/directory"}'
```

### Example Response

```json
{
  "stdout": "Hello World\n",
  "stderr": "",
  "exit_code": 0
}
```

## Security Considerations

⚠️ **Warning**: This server executes shell commands directly. In a production environment, this could pose serious security risks. Use with caution and implement proper authentication, authorization, and input validation before deploying in any non-isolated environment.
