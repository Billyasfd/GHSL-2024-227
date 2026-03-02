#!/bin/bash
# This is the legitimate setup script
mkdir -p ./bin
echo "echo 'Running Legitimate Build Tool v1.0'" > ./bin/helper-tool
chmod +x ./bin/helper-tool
echo "Setup complete."