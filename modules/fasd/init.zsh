#
# Maintains a frequently used file and directory list for fast access.
#
# Authors:
#   Wei Dai <x@wei23.net>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Load dependencies.
pmodload 'editor'

# If the command doesn't exist externally, we need to fall back to the bundled
# submodule.
if (( ! $+commands[fasd] )); then
  source "${0:h}/external/fasd" || return 1
fi

#
# Initialization
#

cache_file="${XDG_CACHE_HOME:-$HOME/.cache}/prezto/fasd-cache.zsh"
if [[ "${commands[fasd]}" -nt "$cache_file" \
      || "${ZDOTDIR:-$HOME}/.zpreztorc" -nt "$cache_file" \
      || ! -s "$cache_file"  ]]; then
  # Set the base init arguments.
  init_args=(zsh-hook)

  # Set fasd completion init arguments, if applicable.
  if zstyle -t ':prezto:module:completion' loaded; then
    init_args+=(zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)
  fi

  mkdir -p "$cache_file:h"
  # Cache init code.
  fasd --init "$init_args[@]" >! "$cache_file" 2> /dev/null
fi

source "$cache_file"

unset cache_file init_args

function fasd_cd {
  local fasd_ret="$(fasd -d "$@")"
  if [[ -d "$fasd_ret" ]]; then
    cd "$fasd_ret"
  else
    print "$fasd_ret"
  fi
}

#
# Aliases
#

if ! zstyle -t ':prezto:module:fasd:alias' skip; then
  # Changes the current working directory interactively.
  alias j='fasd_cd'                # Changes the current working directory.
  alias z='fasd_cd -i'             # Changes the current working directory interactively.
  alias v="fasd -f -e ${EDITOR}"   # quick opening files with vim
  alias t="fasd -f -e \"less +F\"" # quick tailling files with less

  if [[ "$OSTYPE" == darwin* ]]; then
    # alias m="fasd -f -e mplayer" # quick opening files with mplayer
    alias o="fasd -f -e open"      # quick opening files with open
  fi
fi
