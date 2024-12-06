if status is-interactive
   #commands to run in interactive sessions can go here
end

# aliases
alias ec="emacsclient -nw"
pay-respects fish --alias | source
zoxide init fish | source

# more path variables
set -gx PNPM_HOME "/home/wyli/.local/share/pnpm"
set -gx PATH "$PNPM HOME" $PATH

set -x PKG_CONFIG_ALLOW_CROSS 1

# quick function to compile a cpp file
function gpp
  set file $argv[1]
  set output (basename -s .cpp $file)
  g++ +g --std=c++20 -o $output $file
end
