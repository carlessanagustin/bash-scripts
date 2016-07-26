#!/bin/bash


##
# Utility logging functions
#
_fatal() { _log 5 "FATAL: $@"; }
_error() { _log 4 "ERROR: $@"; }
_warn()  { _log 3 "WARN:  $@"; }
_info()  { _log 2 "INFO:  $@"; }
_debug() { _log 1 "DEBUG: $@"; }
_trace() { _log 0 "TRACE: $@"; } # Always prints
function _log() {
  level=$1
  shift
  if [[ $_V -ge $level ]]; then
    echo "$@"
  fi
}


##
# Employs wget in order to download a file into directory ${HOME}/Downloads
#
# @param url:    source URL
# @param dst:    (optional) destination file name
# @param cookie: (optional) cookie to be employed in case authorization is required
#
function download() {
  url="$1"
  cookie="$2"

  dst=${dst:=$(basename $url)}

  pushd ${HOME}/Downloads > /dev/null 2>&1
  if [ ! -f ${dst} ] ;then
    if [ -z "$cookie" ] ;then
      wget --quiet -O "${dst}" "${url}"
    else
      _info wget --quiet --no-cookies --no-check-certificate --header "Cookie: ${cookie}" "${url}"
      wget --quiet --no-cookies --no-check-certificate --header "Cookie: ${cookie}" "${url}"
    fi
  fi
  popd > /dev/null 2>&1
}
