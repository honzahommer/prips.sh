#!/usr/bin/env bash
set -e

__dirname() {
  local s="${1:-$0}"
  local d

  while [ -h "$s" ]; do
    d="$(cd -P "$(dirname "$s")" >/dev/null 2>&1 && pwd)"
    s="$(readlink "$s" 2>&1)"

    [[ $s != /* ]] && s="$d/$s"
  done

  cd -P "$(dirname "$s")" >/dev/null 2>&1 && pwd
}

readonly PRIPS_PREFIX="${1:-$PREFIX}"
readonly PRIPS_ROOT="$(__dirname "$0")"

mkdir -p "$PRIPS_PREFIX"/{bin,libexec}

cp -R "$PRIPS_ROOT"/bin/* "$PRIPS_PREFIX"/bin
cp -R "$PRIPS_ROOT"/libexec/* "$PRIPS_PREFIX"/libexec

echo "Installed prips.sh to $PRIPS_PREFIX/bin/prips.sh"
