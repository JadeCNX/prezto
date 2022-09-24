#
# A cat(1) clone with syntax highlighting and Git integration.
# https://github.com/sharkdp/bat
#

if type "bat" > /dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export PAGER="bat --style='changes'"
  alias cat="bat -pp"

  help() {
      "$@" --help 2>&1 | bat --plain --language=help
  }
  alias h='help'
fi

gdB() {
    git diff --name-only --relative --diff-filter=d | xargs bat --style=full --diff
}
