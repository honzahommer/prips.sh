#!/usr/bin/env bash
set -e

prips() {
  prips:help() {
    cat << EOF 1>&2
usage: $_this [options] <start> <end>
        -n <x> set the number of addresses to print (<end> must not be set)
        -f <x> set the format of addresses (hex, dec, or dot)
        -i <x> set the increment to 'x'
        -h     display this help message and exit
        -v     display the version number and exit
EOF
    exit 1
  }

  prips:error() {
    local code=1

    case ${1} in
      -[0-9]*)
       code=${1#-}
       shift
       ;;
    esac

    echo "$_this: $*" 1>&2
    exit "$code"
  }

  prips:aton() {
    local ip=$1
    local ipnum=0

    for (( i=0; i<4; ++i )); do
      ((ipnum+=${ip%%.*}*$((256**$((3-i))))))
      ip=${ip#*.}
    done

    echo $ipnum
  }

  prips:ntoa() {
    echo -n $(($(($(($((${1}/256))/256))/256))%256)).
    echo -n $(($(($((${1}/256))/256))%256)).
    echo -n $(($((${1}/256))%256)).
    echo $((${1}%256))
  }

  prips:isint() {
    (( $1 > 0 )) 2>/dev/null
  }

  prips:isip() {
    [[ $1 =~ ^[0-9]+(\.[0-9]+){3}$ ]]
  }

  prips:set() {
    local var=$1
    local val=${2:-$3}

    case ${var} in
      f)
        var="format"

        ! echo "${_formats[@]}" | grep -qw "$val" && \
          prips:error "invalid format '$val'"
        ;;
      i)
        var="increment"

        ! prips:isint "$val" && \
          prips:error "$var must be a positive integer"
        ;;
      n)
        var="count"

        ! prips:isint "$val" && \
          prips:error "$var must be a positive integer"

        args=1
        ;;
      t)
        var="_this"
        ;;
      start | end)
        prips:isip "$val" && \
          val=$(prips:aton "$val")

        ! prips:isint "$val" && \
          prips:error "bad IP address"
        ;;
    esac

    eval "$var=\"$val\""
  }

  local _formats=("dec" "dot" "hex")
  local _this="prips"
  local _version="0.1.0"

  local args=2
  local count=0
  local increment=1
  local format="dot"
  local start
  local end

  while getopts "f:i:n:t:?hv" opt; do
    case ${opt} in
      f | i | n | t)
        prips:set "$opt" "$OPTARG"
        ;;
      v)
        prips:error -0 "v$_version"
        ;;
      h | \? | :)
        prips:help
        ;;
    esac
  done
  shift $((OPTIND -1))

  if [ $# -ne $args ]; then
    prips:help
  fi

  prips:set start "$1"
  prips:set end "$2" "$(( start + (increment * count) - 1 ))"

  [[ $end -lt $start ]] && \
    prips:error "start address must be smaller than end address"

  while [[ $start -le $end ]]; do
    case ${format} in
      dec)
        echo "$start"
        ;;
      hex)
        printf '%X\n' "$start"
        ;;
      *)
        prips:ntoa "$start"
        ;;
    esac

    start=$(( start + increment ))
  done
}

if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then
  prips -t "$(basename "$0")" "$@"
fi
