gf() {
    if [ "$1" = "worktree" ] && [ "$2" = "switch" ]; then
        local _gf_dir
        _gf_dir="$(command gitforge "$@")" || return
        if [ -n "$_gf_dir" ]; then
            builtin cd -- "$_gf_dir" || return
        fi
    else
        command gitforge "$@"
    fi
}

if complete -p gitforge &>/dev/null; then
    eval "$(complete -p gitforge | sed 's/ gitforge$/ gf/')"
fi
