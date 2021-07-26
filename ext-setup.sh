#!/bin/bash


# Check for VSCode
if ! [ -x "$(command -v code)" ]; then
  echo 'Error: VSCode is not installed.' >&2
  exit 1
else
  # code --install-extension psioniq.psi-header
  echo "vscode found. OK"
fi

# This script relies on jq
REQUIRED_PKG="jq"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG | grep "install ok installed")

# Check for jq and install if not found
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG found. Setting up $REQUIRED_PKG."
fi


if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt-get --yes install $REQUIRED_PKG
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew install $REQUIRED_PKG
  exit 0
else
  echo "Unsupported OS. Sorry."
  exit 0
fi