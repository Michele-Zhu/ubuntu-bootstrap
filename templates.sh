#!/usr/bin/env bash
# Exit if it fails
set -e

echo "Setting up templates"

mkdir -p ~/Templates

touch ~/Templates/"text.txt"

# Python template
cat > ~/Templates/"python.py" <<'EOF'

def main():
    pass


if __name__ == "__main__":
    main()
EOF

# markdown template
cat > ~/Templates/"markdown.md" <<'EOF'
# Title

## Overview

Brief description of what this is about.

## Notes

- 
- 
- 

## Resources

- 
EOF

# Markdown template
cat > ~/Templates/"script.sh" <<'EOF'
#!/usr/bin/env bash

set -euo pipefail


main() {
    echo "Hello, world!"
}


main "$@"
EOF

echo "Done!"
