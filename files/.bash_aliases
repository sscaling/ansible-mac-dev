alias ll='ls -FGlAhp'

alias mvnc='mvn clean verify cobertura:cobertura'

# dvm https://github.com/getcarina/dvm
alias dvm-init='[[ -s "$(brew --prefix dvm)/dvm.sh" ]] && source "$(brew --prefix dvm)/dvm.sh"'

alias dc=/usr/local/bin/docker-compose
alias dps='docker ps'
alias dm=docker-machine
alias flushdns='sudo killall -HUP mDNSResponder'
alias params='echo $@'

# login to the docker machine XHyve VM
alias docker-login='screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty'

gitchanged() {
  PARAMS=$@
  git diff $PARAMS | awk -F'\n' 'BEGIN { ADD=DEL=0; } { if (match($0, "^-")) { DEL++; } else if (match($0, "^[+]")) { ADD++; } } END {print ADD " additions, " DEL " deletions, " (ADD - DEL) " net"}'
}

dockerls() {
  docker ps | grep -v CONTAINER | awk '{i++; printf "%s %-50s %s\n", i, $NF, $2}'
}

dockermnt() {
  CONTAINER=`docker ps | grep -v "CONTAINER ID" | awk -F' ' '{print $NF}' | head -n $1 | tail -n 1`
  docker exec -i -t $CONTAINER /bin/bash
}

dockerip() {
  docker inspect --format '{{printf "%s %s" .NetworkSettings.IPAddress .Name  }}' `docker ps | grep -v CONTAINER | awk '{print $NF}'`
}

clearws() {
  sed -E -i.wsbak -e's/[[:space:]]*$//' "$1"
}


