#
# Defines Homebrew aliases.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Load dependencies.
pmodload 'helper'

# Return if requirements are not found.
if ! is-darwin && ! is-linux; then
  return 1
fi

#
# Variables
#

# Load standard Homebrew shellenv into the shell session.
# Load 'HOMEBREW_' prefixed variables only. Avoid loading 'PATH' related
# variables as they are already handled in standard zsh configuration.
if (( $+commands[brew] )); then
  eval "${(@M)${(f)"$(brew shellenv 2> /dev/null)"}:#export HOMEBREW*}"
fi

if [[ "$OSTYPE" == darwin* ]]; then
  HB_CNF_HANDLER="$(brew --prefix)/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
  if [ -f "$HB_CNF_HANDLER" ]; then
    source "$HB_CNF_HANDLER";
  fi
fi

#
# Aliases
#

# Homebrew
if ! zstyle -t ':prezto:module:homebrew:alias' skip; then
  alias brewc='brew cleanup'
  alias brewI='brew info'
  alias brewi='brew install'
  alias brewL='brew leaves'
  alias brewl='brew list'
  alias brewo='brew outdated'
  alias brewr='brew reinstall'
  alias brews='brew search'
  alias brewu='brew upgrade'
  alias brewx='brew uninstall'

  # Homebrew Cask
  alias caski='brew install --cask'
  alias caskl='brew list --cask'
  alias casko='brew outdated --cask'
  alias casks='brew search --cask'
  alias casku='brew upgrade --cask'
  alias caskx='brew uninstall --cask'
fi
