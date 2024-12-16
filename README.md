# Port Check Script

A Bash script to test outbound TCP connectivity from your local Linux machine. This script uses the `/dev/tcp` descriptor to check if specific ports are open for outbound traffic. It's simple, interactive, and requires no external dependencies like `nc` (netcat).

## Features

- Dynamically prompt the user for:
  - Target server (IP address or hostname).
  - Number of ports to check.
  - Ports to test.
- Validates target server and port inputs.
- Uses the Bash built-in `/dev/tcp` for lightweight and dependency-free operation.
- Provides clear results for each port: **open** or **blocked**.

## Prerequisites

- A Linux system with Bash support for `/dev/tcp` (most modern systems have this enabled by default).

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/Y3llowDuck/port_check.git

1. Go to location. Make the file executable:
   ```bash
   cd port_check
   chmod +x port_check.sh
   
## Example Output

Here’s an example of what running the script looks like:

![Script Output Example](https://github.com/Y3llowDuck/port_check/blob/main/Screenshot%202024-12-16%20at%201.42.52%20PM.png?raw=true)

