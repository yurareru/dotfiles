source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/zen.toml)"
eval "$(zoxide init zsh)"

alias neofetch="fastfetch"
alias cd="z"
alias ls="eza"
alias ll="eza -lah"
alias neo="neo-matrix -Dc cyan"
