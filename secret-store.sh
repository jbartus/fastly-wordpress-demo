fastly secret-store list --json --quiet | jq '.[] | select(.name == "secrets")'