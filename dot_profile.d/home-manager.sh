function hm() {
    os=$(uname)
    current_dir=`pwd`
    cd ${HOME}/.config/home-manager
    nix flake update
    if [[ "$os" == "Darwin" ]]; then
        sudo darwin_rebuild switch --flake .#$(hostname -s)

    else
        home_manager_switch
    fi
    cd $current_dir
}
