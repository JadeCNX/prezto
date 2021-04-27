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

  # starship init zsh --print-full-init > starship___init.zsh
  eval "$(starship init zsh --print-full-init)"
}

prompt_starship_setup "$@"



