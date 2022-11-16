if command -sq starship
  set -gx STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/config.toml"
  starship init fish | source
end
