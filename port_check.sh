#!/bin/bash

# Function to validate if the target is a valid IP or hostname
validate_target() {
  local target=$1
  # Check if the target is a valid IP address
  if [[ $target =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    return 0  # Valid IP
  fi
  # Check if the target is a valid hostname
  if [[ $target =~ ^(([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}|localhost)$ ]]; then
    return 0  # Valid hostname
  fi
  return 1  # Invalid target
}

# Prompt user for the target server
read -p "Enter the target server (default: portquiz.net): " TARGET
TARGET=${TARGET:-portquiz.net}  # Use portquiz.net if no input is given

# Validate the target server
if ! validate_target "$TARGET"; then
  echo "Invalid target server. Please provide a valid IP address or hostname."
  exit 1
fi

# Ask user how many ports to check
read -p "How many ports would you like to check? " NUM_PORTS

# Collect port numbers from the user
PORTS=()
for ((i = 1; i <= NUM_PORTS; i++)); do
  read -p "Enter port number $i: " PORT
  # Validate port number
  if ! [[ $PORT =~ ^[0-9]+$ ]] || [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
    echo "Invalid port number: $PORT. Please enter a valid port (1-65535)."
    exit 1
  fi
  PORTS+=("$PORT")
done

# Function to check local outbound connectivity using /dev/tcp
check_port() {
  local port=$1
  if (exec 3<>/dev/tcp/"$TARGET"/"$port") 2>/dev/null; then
    echo "Outbound connection successful on port $port"
    exec 3<&-  # Close input stream
    exec 3>&-  # Close output stream
  else
    echo "Outbound connection blocked on port $port"
  fi
}

# Main script loop
echo "Checking outbound connectivity to $TARGET..."
for port in "${PORTS[@]}"; do
  check_port "$port"
done

# --- HOW TO BLOCK OUTBOUND TRAFFIC ---
# Use iptables to block outbound TCP traffic on a specific port:
# sudo iptables -A OUTPUT -p tcp --dport <PORT> -j DROP
# Example for port 8030:
# sudo iptables -A OUTPUT -p tcp --dport 8030 -j DROP
# Verify the iptables rule:
# sudo iptables -L OUTPUT -v -n
# Remove the iptables rule (if needed):
# sudo iptables -D OUTPUT -p tcp --dport <PORT> -j DROP

# Use nftables to block outbound TCP traffic on a specific port:
# sudo nft add rule ip filter output tcp dport <PORT> drop
# Example for port 8030:
# sudo nft add rule ip filter output tcp dport 8030 drop
# Verify the nftables rule:
# sudo nft list ruleset
# Remove the nftables rule (if needed):
# sudo nft delete rule ip filter output tcp dport <PORT>
# --------------------------------------
