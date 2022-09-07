set -gx LESSHISTFILE "$XDG_CACHE_HOME/less/history"

set -gx TERMINFO "$XDG_DATA_HOME/terminfo"
set -gx TERMINFO_DIRS "$TERMINFO:/usr/share/terminfo"

set -gx GOPATH "$XDG_DATA_HOME/go"

set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -gx pm_config_cache "$XDG_CACHE_HOME/npm"
