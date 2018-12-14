# Shell Script

1. Use `#!/usr/bin/env bash`

1. Set exit on error, exit on unset variable and exit on pipe failure.<br/>
`set -euo pipefail`

1. Set a `${BASE}` variable<br/>
`BASE=$(readlink -f $(dirname $0)/..)`

3. Add a usage function<br/>
`usage() { echo "Usage: $(basename $0) [-o OUTFILE] FILE" 2>&1; exit 1; }`

4. Echo error messages to STDERR<br/>
`echo "Error message...." 2>&1` }`
