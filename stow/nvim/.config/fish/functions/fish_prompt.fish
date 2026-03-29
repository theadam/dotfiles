function fish_prompt
    set -l __last_command_exit_status $status

    if not set -q __fish_git_prompt_show_informative_status
        set -g __fish_git_prompt_show_informative_status 1
    end
    if not set -q __fish_git_prompt_hide_untrackedfiles
        set -g __fish_git_prompt_hide_untrackedfiles 1
    end
    if not set -q __fish_git_prompt_color_branch
        set -g __fish_git_prompt_color_branch magenta --bold
    end
    if not set -q __fish_git_prompt_showupstream
        set -g __fish_git_prompt_showupstream informative
    end
    if not set -q __fish_git_prompt_color_dirtystate
        set -g __fish_git_prompt_color_dirtystate blue
    end
    if not set -q __fish_git_prompt_color_stagedstate
        set -g __fish_git_prompt_color_stagedstate yellow
    end
    if not set -q __fish_git_prompt_color_invalidstate
        set -g __fish_git_prompt_color_invalidstate red
    end
    if not set -q __fish_git_prompt_color_untrackedfiles
        set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
    end
    if not set -q __fish_git_prompt_color_cleanstate
        set -g __fish_git_prompt_color_cleanstate green --bold
    end

    set -l cyan (set_color -o cyan)
    set -l yellow (set_color -o yellow)
    set -l red (set_color -o red)
    set -l green (set_color -o green)
    set -l blue (set_color -o blue)
    set -l normal (set_color normal)

    set -l arrow_color "$green"
    if test $__last_command_exit_status != 0
        set arrow_color "$red"
    end

    set -l arrow "$arrow_color➜ "
    if fish_is_root_user
        set arrow "$arrow_color# "
    end

    set -l cwd $cyan(basename (prompt_pwd))

    # Git repo name and worktree detection
    set -l repo_info ""
    set -l is_worktree false
    set -l rel_path ""
    set -l toplevel (git rev-parse --show-toplevel 2>/dev/null)
    if test -n "$toplevel"
        set -l repo_name (basename $toplevel)

        # Linked worktrees have a .git file (not directory)
        if test -f "$toplevel/.git"
            set is_worktree true
            set repo_name (basename (dirname $toplevel))
        # Main checkout inside a worktree-root dir (e.g. hookipa/master)
        else if test -f (dirname $toplevel)"/.worktree-root"
            set repo_name (basename (dirname $toplevel))
        end

        # Build relative path from repo root to cwd
        set rel_path (string replace "$toplevel" "" -- (pwd))
        set rel_path (string replace -r '^/' '' -- $rel_path)
        if test -n "$rel_path"
            set cwd $blue"/"$rel_path
        else
            set cwd ""
        end

        set repo_info "$cyan$repo_name$normal"
    end

    set -l vcs (fish_vcs_prompt)
    if $is_worktree
        # Merge worktree indicator into git prompt: (branch|✔) → (wt:branch|✔)
        set -l wt_prefix $cyan"wt:"(set_color normal)
        set vcs (string replace '(' '('$wt_prefix -- $vcs)
        # Skip cwd when it matches branch name (redundant)
        set -l branch (git symbolic-ref --short HEAD 2>/dev/null)
        if test "$rel_path" = "$branch"
            set cwd ""
        end
    end

    if test -n "$cwd"
        echo -n -s $arrow ' '$repo_info$cwd $vcs $normal ' '
    else
        echo -n -s $arrow ' '$repo_info $vcs $normal ' '
    end
end
