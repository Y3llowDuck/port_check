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

## Example Output

Here’s an example of what running the script looks like:

```plaintext
Enter the target server (default: portquiz.net): portquiz.net
How many ports would you like to check? 3
Enter port number 1: 80
Enter port number 2: 443
Enter port number 3: 8080

Checking outbound connectivity to portquiz.net...
Outbound connection successful on port 80
Outbound connection successful on port 443
Outbound connection blocked on port 8080

