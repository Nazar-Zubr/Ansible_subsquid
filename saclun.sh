#!/usr/bin/env bash
set -e

# Set static variables
WARNING_AGREE="y"
input="~/.shardeum"
DASHPORT_DEFAULT=8080
EXTERNALIP_DEFAULT=auto
INTERNALIP_DEFAULT=auto
SHMEXT_DEFAULT=9001
SHMINT_DEFAULT=10001
DASHPASS="123467"
RUNDASHBOARD="y"
CHANGEPASSWORD="y"

# Function to exit with an error message
exit_with_error() {
    echo "Error: $1"
    exit 1
}

# Check the operating system and get the processor information
environment=$(uname)
case "$environment" in
    Linux)
        processor=$(uname -m)
        ;;
    Darwin)
        processor=$(uname -m)
        ;;
    *MINGW*)
        exit_with_error "$environment (Windows) environment not yet supported. Please use WSL (WSL2 recommended) or a Linux VM. Exiting installer."
        ;;
    *)
        processor="Unknown"
        ;;
esac

# Check for ARM processor or Unknown and exit if true, meaning the installer is not supported by the processor
if [[ "$processor" == *"arm"* || "$processor" == "Unknown" ]]; then
    exit_with_error "$processor not yet supported. Exiting installer."
fi

# Print the detected environment and processor
echo "$environment environment with $processor found."

# Check if any hashing command is available
if ! (command -v openssl > /dev/null || command -v shasum > /dev/null || command -v sha256sum > /dev/null); then
  echo "No supported hashing commands found."
  exit_with_error "Please install openssl, shasum, or sha256sum and try again."
fi

# Diagnostic data collection agreement
echo "By running this installer, you agree to allow the Shardeum team to collect this data."
echo "Diagnostic data collection agreement accepted."

# Set base directory
echo "The base directory is set to: $input"

# Check if input starts with "/" or "~/", if not, add "~/"
if [[ ! $input =~ ^(/|~\/) ]]; then
  input="~/$input"
fi

# Check all things that will be needed for this script to succeed like access to docker and docker-compose
# If any check fails exit with a message on what the user needs to do to fix the problem
command -v git >/dev/null 2>&1 || { echo >&2 "'git' is required but not installed."; exit 1; }
command -v docker >/dev/null 2>&1 || { echo >&2 "'docker' is required but not installed. See https://gitlab.com/shardeum/validator/dashboard/-/tree/dashboard-gui-nextjs#how-to for details."; exit 1; }
if command -v docker-compose &>/dev/null; then
  echo "docker-compose is installed on this machine"
elif docker --help | grep -q "compose"; then
  echo "docker compose subcommand is installed on this machine"
else
  echo "docker-compose or docker compose is not installed on this machine"
  exit 1
fi

# Set Docker default platform
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# Function to get external IP
get_external_ip() {
  echo "External IP address: auto"
}

# Function to get local IP
get_ip() {
  echo "Local IP address: auto"
}

# Function to hash password
hash_password() {
  local input="$1"
  local hashed_password=""

  # Try using openssl
  if command -v openssl > /dev/null; then
    hashed_password=$(echo -n "$input" | openssl dgst -sha256 -r | awk '{print $1}')
    echo "$hashed_password"
    return 0
  fi

  # Try using shasum
  if command -v shasum > /dev/null; then
    hashed_password=$(echo -n "$input" | shasum -a 256 | awk '{print $1}')
    echo "$hashed_password"
    return 0
  fi

  # Try using sha256sum
  if command -v sha256sum > /dev/null; then
    hashed_password=$(echo -n "$input" | sha256sum | awk '{print $1}')
    echo "$hashed_password"
    return 0
  fi

  return 1
}

# Check Docker daemon status
if [[ "$(docker info 2>&1)" == *"Cannot connect to the Docker daemon"* ]]; then
    echo "Docker daemon is not running"
    exit 1
else
    echo "Docker daemon is running"
fi

# Continuing with the script...
# (Add the rest of the script here)
