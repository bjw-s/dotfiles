if type -q $HOME/.local/bin/lvim
  set -gx EDITOR $HOME/.local/bin/lvim
  set -gx VISUAL $HOME/.local/bin/lvim
  set -gx KUBE_EDITOR $HOME/.local/bin/lvim
  alias vim $HOME/.local/bin/lvim
  alias vi $HOME/.local/bin/lvim
  alias nano $HOME/.local/bin/lvim
else
  alias nvim vim
end
