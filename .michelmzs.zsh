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

# https://github.com/ohmyzsh/ohmyzsh/pull/9090
export ZSH_COMPDUMP="${ZSH_CACHE_DIR}/.zcompdump-${(%):-%m}-${ZSH_VERSION}"

unset TERRAGRUNT_DOWNLOAD
# export TERRAGRUNT_DOWNLOAD="$HOME/.terraform.d/terragrunt-cache/"

# Aliases
if [[ -x "$(command -v vimx)" ]]; then alias vim='vimx'; fi

alias mdiff="diff -y --suppress-common-lines"
alias asdf-all="cut -d ' ' -f1 .tool-versions | xargs -I{} asdf plugin-add {}"

alias tgp="terragrunt plan"
alias tgia="terragrunt init && terragrunt apply"
alias tgf="terragrunt hclfmt"
alias tgcc="find . -type d -name '.terragrunt-cache' -prune -exec rm -rf {} \;"
alias tguk="terragrunt force-unlock"

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
	echo | openssl s_client -servername $hostname -connect $hostname:$port -starttls $type 2>/dev/null | openssl x509 -noout -dates
}

function sshm() {
	host=$1
	ssh michel.santello@"${host}"
}

function podman-cleanup() {
	podman container cleanup -a
	podman volume prune
	podman image prune
}

function zsh_history-backup() {
	# TODO Refactor hard coded paths
	todays_backups=$(find ~/tmp/backups/ -name "zsh_history_$(date +"%Y-%m-%d")*" | wc -l)

	if [[ $todays_backups -eq 0 ]]; then
		tar zcvf ~/tmp/backups/zsh_history_$(date +"%Y-%m-%d_%Hh-%Mm").gz ~/.zsh_history &>/dev/null
		if [[ -d "/mnt/c/backup/wsl" ]]; then
			current_backup=$(find ~/tmp/backups/ -name "zsh_history_$(date +"%Y-%m-%d")*" | sort -r | head -n 1)
			cp "$current_backup" /mnt/c/backup/wsl
		fi
	fi
}

# Functions executed after terminal load

# ZSH History backup
zsh_history-backup

# Trash recycle
# trash-empty 90
