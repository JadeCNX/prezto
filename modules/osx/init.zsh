#
# Defines macOS aliases and functions.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Load dependencies.
pmodload 'helper'


# Return if requirements are not found.
if ! is-darwin; then
  return 1
fi

#
# Aliases
#

# Changes directory to the current Finder directory.
alias cdf='cd "$(pfd)"'

# Pushes directory to the current Finder directory.
alias pushdf='pushd "$(pfd)"'

alias hidden-show='defaults write com.apple.finder AppleShowAllFiles -bool YES && killall Finder'
alias hidden-hide='defaults write com.apple.finder AppleShowAllFiles -bool NO && killall Finder'

alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
alias afk='open -a /System/Library/CoreServices/ScreenSaverEngine.app'

alias apps="osascript -e 'tell application \"System Events\" to get name of (processes where background only is false)'"
