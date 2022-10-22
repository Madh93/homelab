# Docker Compose basics
alias dp='docker ps'
alias dtail='docker logs -tf --tail="50" "$@"'
alias dcup='docker-compose up -d'
alias dcdown='docker-compose down'
alias dclogs='docker-compose logs -tf --tail="50"'
alias dcpull='docker-compose pull'

# Docker Compose like a pro
_filter_service() {
  service="$1" && [ -z "$1" ] && service=$(ls -l $COMPOSE_DIR | grep '^d' | awk '{print $NF}' | fzf)
}
up() {
  _filter_service $1
  docker-compose -f $COMPOSE_DIR/$service/docker-compose.yml up -d
}
down() {
  _filter_service $1
  docker-compose -f $COMPOSE_DIR/$service/docker-compose.yml down
}
restart() {
  _filter_service $1
  down $service && sleep 1 && up $service
}
pull() {
  _filter_service $1
  docker-compose -f $COMPOSE_DIR/$service/docker-compose.yml pull
}
update() {
  _filter_service $1
  pull $service && restart $service
}
logs() {
  _filter_service $1
  docker-compose -f $COMPOSE_DIR/$service/docker-compose.yml logs -tf --tail=50
}
