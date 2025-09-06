# source python virtual environment
alias senv="if [ -d .venv ]; then source .venv/bin/activate; else source venv/bin/activate; fi"
alias loadenv='[ -f .env ] && { set -a; source .env 2>/dev/null; set +a; echo ".env loaded."; } || echo "No .env file found."'
alias loadenv_dev='[ -f .dev.env ] && { set -a; source .dev.env 2>/dev/null; set +a; echo ".dev.env loaded."; } || echo "No .dev.env file found."'
