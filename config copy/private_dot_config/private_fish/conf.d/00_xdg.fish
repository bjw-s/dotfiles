set UID (id -u (whoami))
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_RUNTIME_DIR "/run/user/$UID"
set -gx XDG_STATE_HOME "$HOME/.local/state"
