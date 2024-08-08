#
# FZF
#

source <(fzf --zsh)

[ -f ~/.fzf_git.zsh ] && source ~/.fzf_git.zsh

# Use ;; as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER=';;'

# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'

export CHEAT_USE_FZF=true

if [ -n "$TMUX" ]; then
  export FZF_TMUX=1
fi

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --follow --exclude ".git" . "$1"
}
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob="!.git/*" --glob="!node_modules/*"'
# export FZF_DEFAULT_COMMAND='fd --type file --follow -E .git -E node_modules'
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
# export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

fzf-binds() {
printf 'ctrl-v:execute(less -K {}),'
printf 'ctrl-e:execute(${EDITOR:-vim} {}),'
printf 'ctrl-u:execute-silent($copy < {}),'
printf 'ctrl-y:execute-silent(echo {} | xargs echo -n | $copy),'
printf 'ctrl-r:execute-silent(realpath {} | xargs echo -n | $copy)'
}

fzf-color() {
printf 'dark,'
printf 'fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe,'
printf 'info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef'
}

export FZF_DEFAULT_OPTS="--bind '$(fzf-binds)' --color '$(fzf-color)'"

source <(fzf --zsh)
