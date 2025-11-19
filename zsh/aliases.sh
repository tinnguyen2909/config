# source python virtual environment
alias senv='
find_and_source_venv() {
    local dir="$PWD"
    while [[ "$dir" != "/" ]]; do
        if [[ -f "$dir/.venv/bin/activate" ]]; then
            source "$dir/.venv/bin/activate"
            echo "Activated virtual environment: $dir/.venv"
            return 0
        fi
        dir="$(dirname "$dir")"
    done
    echo "No .venv found in current directory or parent directories"
    return 1
}
find_and_source_venv'
alias loadenv='[ -f .env ] && export $(grep -v "^#" .env | grep -v "^$" | xargs) || echo ".env file not found"'
alias loadenv_dev='[ -f .env.dev ] && export $(grep -v "^#" .env.dev | grep -v "^$" | xargs) || echo ".env.dev file not found"'
tcopy() {
  tmux show-buffer | xsel -ib
}
