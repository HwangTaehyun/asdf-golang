#!/usr/bin/env bash

set -euo pipefail

# Get the real path to the `go` binary installed by asdf
go_path=$(asdf which go)

# Define a function to wrap `go install` and call `asdf reshim` if necessary
wrap_go_install() {
  local cmd="$1"
  shift

  # Check if the command is `install` and run it
  if [[ "$cmd" == "install" ]]; then
    "$go_path" install "$@"

    # Run asdf reshim after installing a package
    echo "Running asdf reshim for golang..."
    asdf reshim golang
  else
    # For any other `go` command, just pass through
    "$go_path" "$cmd" "$@"
  fi
}

# Call the function with the provided arguments
wrap_go_install "$@"