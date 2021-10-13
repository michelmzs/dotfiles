
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
