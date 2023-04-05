function brewup --description "Update brew installation"
  if type -q brew
    brew update
    brew upgrade
    brew cleanup
    brew doctor
  end
  if type -q mas
    mas upgrade
  end
end
