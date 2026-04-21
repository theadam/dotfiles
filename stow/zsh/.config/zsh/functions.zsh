# @ — ask claude to write a shell command, push it onto the next prompt
@() {
  if [ $# -eq 0 ]; then
    echo "Usage: @ <describe what you want to do>"
    return 1
  fi

  local os
  os="$(uname -s | tr '[:upper:]' '[:lower:]')"
  local prompt="You are a command-line generator. Output ONLY the exact shell command needed, nothing else. No explanation, no markdown, no backticks, no newlines before or after. Just the raw command. The shell is zsh on $os.

User request: $*"

  print -n "thinking..." >&2
  local cmd
  cmd="$(claude -p "$prompt" --model sonnet 2>/dev/null)"
  print -n "\r           \r" >&2

  if [ -z "$cmd" ]; then
    echo "Failed to generate command." >&2
    return 1
  fi

  print -z -- "$cmd"
}

# awsp — run a command under an AWS profile, logging in first if needed
awsp() {
  if [ $# -lt 2 ]; then
    echo "Usage: awsp <profile> <command> [args...]" >&2
    return 1
  fi

  local profile="$1"
  shift

  if ! aws sts get-caller-identity --profile "$profile" >/dev/null 2>&1; then
    echo "Not logged in to AWS profile '$profile'. Logging in..."
    aws login --profile "$profile"

    if ! aws sts get-caller-identity --profile "$profile" >/dev/null 2>&1; then
      echo "AWS login failed for profile '$profile'" >&2
      return 1
    fi
  fi

  local -a env_args
  env_args=("${(@f)$(aws configure export-credentials --profile "$profile" --format env-no-export)}")

  env "${env_args[@]}" "$@"
}
