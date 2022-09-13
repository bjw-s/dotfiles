if command -sq lvim
  set -gx EDITOR lvim
  set -gx VISUAL lvim
  set -gx KUBE_EDITOR lvim
  alias vim lvim
  alias vi lvim
  alias nano lvim
else if command -sq nvim
  set -gx EDITOR nvim
  set -gx VISUAL nvim
  set -gx KUBE_EDITOR nvim
  alias vim nvim
  alias vi nvim
  alias nano nvim
end

if command -sq bat
  set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
end
