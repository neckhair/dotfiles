function dcopen
  if set -q argv[1]
    set service $argv[1]
  else
    set service 'app'
  end
  echo "Opening service $service in the browser."

  set url (dc ps $service | awk '/0.0.0.0/ {print $NF}' | awk -F '->' '{print "http://"$1}')
  open $url
end

