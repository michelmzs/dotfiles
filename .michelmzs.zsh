# ZSH History
HISTSIZE=500000
SAVEHIST=500000
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# Aliases
alias mdiff="diff -y --suppress-common-lines"
alias asdf-all="cut -d' ' -f1 .tool-versions|xargs -i asdf plugin-add {}"

alias tp="terragrunt plan"
alias tgia="terragrunt init && terragrunt apply"

alias zreload="source ~/.zshrc"
alias zedit="vim ~/.zshrc"
alias rm='echo "Please prefer the trash command."; false'

# Functions
function tfgrep () {
	grep -nir "${1}" --exclude-dir '.terragrunt-cache' --exclude-dir '.terraform' --include='*.tf' --include='*.hcl'
}
