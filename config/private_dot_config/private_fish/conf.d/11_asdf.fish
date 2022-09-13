if test -f $HOME/.asdf/asdf.fish
  set -gx ASDF_DATA_DIR "$XDG_DATA_HOME/asdf"
  source $HOME/.asdf/asdf.fish
end

if test -f $HOME/.asdf/completions/asdf.fish
  source $HOME/.asdf/completions/asdf.fish
end
