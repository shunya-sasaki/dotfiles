# Docker
function docker-login-github-cr() {
    echo "$CR_PAT" | docker login ghcr.io -u "${GITHUB_USERNAME}" --password-stdin
}
