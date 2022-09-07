# Set up homebrew
fish_add_path "/opt/homebrew/bin"
fish_add_path "/opt/homebrew/sbin"
fish_add_path "/opt/homebrew/opt/curl/bin"
fish_add_path "/opt/homebrew/opt/grep/libexec/gnubin"
fish_add_path "/opt/homebrew/opt/gnu-sed/libexec/gnubin"
fish_add_path "/opt/homebrew/opt/gnu-tar/libexec/gnubin"
fish_add_path "/opt/homebrew/opt/coreutils/libexec/gnubin"
fish_add_path "/opt/homebrew/opt/libpq/bin"
set -gx HOMEBREW_NO_ANALYTICS 1

set -gx LDFLAGS "-L/opt/homebrew/lib -L/opt/homebrew/opt/openssl@3/lib"
set -gx CPPFLAGS "-I/opt/homebrew/include -I/opt/homebrew/opt/openssl@3/include"
