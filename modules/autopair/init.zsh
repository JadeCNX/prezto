#
# A simple plugin that auto-closes, deletes and skips over matching delimiters in zsh intelligently
# https://github.com/hlissner/zsh-autopair
#

if [[ -e $(brew --prefix)/share/zsh-autopair/autopair.zsh ]]; then
  source $(brew --prefix)/share/zsh-autopair/autopair.zsh
fi
