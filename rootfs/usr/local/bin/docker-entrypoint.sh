#!/bin/sh
set -eu -o pipefail

# Setup network routes if file exists
if [ -f '/etc/route.conf' ]; then
  echo "==> Adding custom routes:"
  while IFS= read -r LINE; do
    # If line is empty skip
    [ -z "${LINE}" ] && continue
    # If line starts with # skip
    [ "${LINE:0:1}" = '#' ] && continue
    # Replace net by -net and host by -host
    echo " - ${LINE}"
    LINE=$(echo "${LINE}" | sed 's/^net/-net/')
    LINE=$(echo "${LINE}" | sed 's/^host/-host/')
    route add ${LINE}
  done < '/etc/route.conf'
fi

# Run command with node if the first argument contains a "-" or is not a system command. The last
# part inside the "{}" is a workaround for the following bug in ash/dash:
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=874264
if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ] || { [ -f "${1}" ] && ! [ -x "${1}" ]; }; then
  set -- node "$@"
fi

exec "$@"