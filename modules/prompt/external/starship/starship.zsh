function prompt_starship_setup {
  if ! command -v starship &> /dev/null; then
    if [ ! -f $HOME/.starship/starship ]; then
      mkdir -p $HOME/.starship
      bash <(curl -fsSL https://starship.rs/install.sh) --yes --bin-dir=$HOME/.starship
    fi
    path=(
      $HOME/.starship
      $path
    )
  fi

  eval "$(starship init zsh)"
}

prompt_starship_setup "$@"

