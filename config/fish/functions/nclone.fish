function nclone --description "Clone a nine repo and cd into it"
  git clone "git@gitlab.nine.ch:ninech/$argv[1]" ~/src/$argv[1]
  cd ~/src/$argv[1]
end

