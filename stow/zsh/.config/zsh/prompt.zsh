# Port of ~/.config/fish/functions/fish_prompt.fish to zsh.
# Pure fish emulation: matches fish's __fish_git_prompt informative-status
# defaults and the user-configured colors from the source fish_prompt.
#
# Status symbols (fish defaults):
#   ✔   clean       (green bold)
#   ✚N  dirty       (modified or deleted, unstaged) — blue
#   ●N  staged      — yellow
#   ✗N  invalid     (merge conflicts) — red
#   ⚑   stash present — default color
#   (untracked files and upstream ahead/behind intentionally not shown —
#    matches fish's __fish_git_prompt_hide_untrackedfiles=1 and the
#    user's disabled showupstream)

autoload -Uz add-zsh-hook

# Populate __ZP_DIRTY / __ZP_STAGED / __ZP_CONFLICTED counts.
function __zp_git_counts() {
  local x y line
  __ZP_DIRTY=0 __ZP_STAGED=0 __ZP_CONFLICTED=0
  while IFS= read -r line; do
    x=${line[1]}; y=${line[2]}
    if [[ $x == '?' && $y == '?' ]]; then
      continue
    fi
    if [[ $x == 'U' || $y == 'U' || ($x == 'A' && $y == 'A') || ($x == 'D' && $y == 'D') ]]; then
      (( __ZP_CONFLICTED++ )); continue
    fi
    [[ $x != ' ' && $x != '?' ]] && (( __ZP_STAGED++ ))
    [[ $y != ' ' && $y != '?' ]] && (( __ZP_DIRTY++ ))
  done < <(git status --porcelain 2>/dev/null)
}

# True (0) if any stash exists.
function __zp_has_stash() {
  git rev-parse --verify --quiet refs/stash >/dev/null 2>&1
}

function __zp_render() {
  local last=$?
  local arrow_color="green"
  (( last != 0 )) && arrow_color="red"
  local sigil="➜"
  (( EUID == 0 )) && sigil="#"
  local arrow="%B%F{$arrow_color}${sigil}%f%b"

  local toplevel
  toplevel=$(git rev-parse --show-toplevel 2>/dev/null)

  if [[ -z "$toplevel" ]]; then
    PROMPT="${arrow}  %B%F{cyan}%1~%f%b "
    return
  fi

  local repo_name=${toplevel:t}
  local is_worktree=0
  if [[ -f "$toplevel/.git" ]]; then
    is_worktree=1
    repo_name=${toplevel:h:t}
  elif [[ -f "${toplevel:h}/.worktree-root" ]]; then
    repo_name=${toplevel:h:t}
  fi

  local rel_path=${PWD#$toplevel}
  rel_path=${rel_path#/}

  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) \
    || branch=$(git rev-parse --short HEAD 2>/dev/null) \
    || branch="?"

  __zp_git_counts
  local has_stash=0
  __zp_has_stash && has_stash=1

  local status_str=""
  local clean=1
  if (( __ZP_DIRTY > 0 )); then
    status_str+="%F{blue}✚${__ZP_DIRTY}%f "; clean=0
  fi
  if (( __ZP_STAGED > 0 )); then
    status_str+="%F{yellow}●${__ZP_STAGED}%f "; clean=0
  fi
  if (( __ZP_CONFLICTED > 0 )); then
    status_str+="%F{red}✗${__ZP_CONFLICTED}%f "; clean=0
  fi
  (( has_stash )) && status_str+="⚑ "
  if (( clean )); then
    if (( has_stash )); then
      status_str="%B%F{green}✔%f%b ⚑"
    else
      status_str="%B%F{green}✔%f%b"
    fi
  fi
  status_str=${status_str% }

  local branch_part="%B%F{magenta}${branch}%f%b"

  local wt_prefix=""
  if (( is_worktree )); then
    wt_prefix="%F{cyan}wt:%f"
    [[ "$rel_path" == "$branch" ]] && rel_path=""
  fi

  local repo_part="%B%F{cyan}${repo_name}%f%b"
  local cwd_part=""
  [[ -n "$rel_path" ]] && cwd_part="%B%F{blue}/${rel_path}%f%b"

  local vcs="(${wt_prefix}${branch_part}|${status_str})"

  if [[ -n "$cwd_part" ]]; then
    PROMPT="${arrow}  ${repo_part}${cwd_part} ${vcs} "
  else
    PROMPT="${arrow}  ${repo_part} ${vcs} "
  fi
}

add-zsh-hook precmd __zp_render
