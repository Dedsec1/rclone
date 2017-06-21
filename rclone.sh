#!/bin/sh
# Download a github project's latest release
# $1: username/repo
# $2: regex to match download file
# example: ./gh-download-latest atom/atom gz

repo=$1
regex=${2:-gz}

wget -qO- https://api.github.com/repos/$repo/releases/latest >/dev/null 2>&1 | \
  awk -v regex="$regex" -F '"' '/browser_download_url/ && match($4, regex) { print $4 }' | \
  xargs wget
