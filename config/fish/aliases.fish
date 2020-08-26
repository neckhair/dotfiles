alias dc "docker-compose"

alias bi "bundle install"
alias be "bundle exec"

alias got "go test"
alias gor "go run"

alias av "ansible-vault --vault-password-file=.vault"

alias gpr "git pull --rebase"

alias kc "kubectl"
alias kns "kubens"

# run curl on kubernetes
alias kubecurl "kubectl run busybox -ti --rm --image=radial/busyboxplus:curl --restart=Never -- curl"
