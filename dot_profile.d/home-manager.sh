function hm() {
    local os current_dir
    os=$(uname)
    current_dir=$(pwd)
    cd "${HOME}/.config/home-manager" || return 1
    nix flake update
    if [[ "$os" == "Darwin" ]]; then
        sudo darwin-rebuild switch --flake ".#$(hostname -s)"
    else
        home-manager switch --flake ".#$(whoami)"
    fi
    cd "$current_dir"
}
