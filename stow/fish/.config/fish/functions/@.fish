function @
    if test (count $argv) -eq 0
        echo "Usage: @ <describe what you want to do>"
        return 1
    end

    set -l prompt "You are a command-line generator. Output ONLY the exact shell command needed, nothing else. No explanation, no markdown, no backticks, no newlines before or after. Just the raw command. The shell is fish on macOS.

User request: $argv"

    echo -n "thinking..." >&2
    set -l cmd (claude -p "$prompt" --model sonnet 2>/dev/null)
    echo -e "\r           \r" >&2

    if test -z "$cmd"
        echo "Failed to generate command." >&2
        return 1
    end

    commandline -r "$cmd"
end
