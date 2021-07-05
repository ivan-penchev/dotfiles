# Delete all remote tracking Git branches where the upstream branch has been deleted
alias git_prune="git fetch --prune && git branch -vv | grep 'origin/.*: gone]' | awk '{print \$1}' | xargs git branch -d"

# Generate a secure password and copy it to clipboard
alias genpw='LC_ALL=C tr -dc "[:alnum:]" < /dev/urandom | head -c 20 | pbcopy'

alias tf='terraform'

# Azure company specific

alias azprod=$(az account -s be9b15b0-30f2-4262-9591-8db092f62606)
alias azdev=$(az account -s 54d00637-e83d-46c2-95bd-42f556a1a5b8)