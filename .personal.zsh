# ZSH History
HISTSIZE=500000
SAVEHIST=500000
setopt INC_APPEND_HISTORY   # Write to the history file immediately, not when the shell exits.
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS    # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS    # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks before recording entry.

# Custom exports
export AWS_PAGER=""
export KUBE_EDITOR="code -w"

unset TERRAGRUNT_DOWNLOAD
# export TERRAGRUNT_DOWNLOAD="$HOME/.terraform.d/terragrunt-cache/"

# Aliases
if [[ -x "$(command -v vimx)" ]]; then alias vim='vimx'; fi

alias mdiff="diff -y --suppress-common-lines"
alias asdf-all="cut -d ' ' -f1 .tool-versions | xargs -I{} asdf plugin-add {}"

# Tools

# Terragrunt
alias tgp="terragrunt plan"
alias tgpw="terragrunt plan --terragrunt-working-dir"
alias tgaw="terragrunt apply --terragrunt-working-dir"
alias tgia="terragrunt init && terragrunt apply"
alias tgf="terragrunt hclfmt"
alias tguk="terragrunt force-unlock"
alias tgcl="find . -type d -name '.terraform.lock.hcl' -prune -exec rm -rf {} \;"
alias tgcc="find . -type d -name '.terragrunt-cache' -prune -exec rm -rf {} \;"
alias zreload="omz reload"
alias zedit="vim ~/.zshrc"
alias rm='echo "Please prefer the trash command."; false'

# Functions
function random-pw() {
	if [ "$1" -gt 0 ]; then
		openssl rand -base64 $1
	else
		openssl rand -base64 32
	fi
}

function mgrep() {
	grep -nir "${1}" --exclude-dir '.terragrunt-cache' --exclude-dir '.terraform' --exclude-dir '.*/'
}

function tfgrep() {
	grep -nir "${1}" --exclude-dir '.terragrunt-cache' --exclude-dir '.terraform' --include='*.tf' --include='*.hcl'
}

function ssl-date-check() {
	# WIP
	echo | openssl s_client -servername $hostname -connect $hostname:$port -starttls $type 2>/dev/null | openssl x509 -noout -dates
}

function podman-cleanup() {
	podman container cleanup -a
	podman volume prune
	podman image prune
}

# Functions executed after terminal load

# Trash recycle 
# TODO move to systemd timer

# trash-empty 90
