#!/usr/bin/env bash

# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

label=$1

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh

vault_ttl=$(vault token lookup | awk '/^ttl\s/ {print $2}'; echo)

main()
{
  # storing the refresh rate in the variable RATE, default is 5
  RATE=$(get_tmux_option "@dracula-refresh-rate" 5)
  OUTPUT_STRING=""
  if [ ! -z "$vault_ttl" ]
  then
    OUTPUT_STRING="VAULT token: ${vault_ttl}"
  fi

  if [ "$OUTPUT_STRING" = "" ]
  then
    OUTPUT_STRING="vault config not valid"
  fi

  if [ "$label" = "" ]
  then
    echo "${OUTPUT_STRING}"
  else
    echo "${label} ${OUTPUT_STRING}"
  fi

  sleep $RATE
}

# run the main driver
main
