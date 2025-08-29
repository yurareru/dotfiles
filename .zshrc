HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

. "$HOME/.local/share/bob/env/env.sh"
export EDITOR=$(which nvim)
export VISUAL=$EDITOR
export PATH=$PATH:/home/yurareru/.local/bin

eval "$(oh-my-posh init zsh --config catppuccin_mocha)"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions 
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light jeffreytse/zsh-vi-mode

zinit ice lucid wait
zinit snippet OMZP::sudo
zinit snippet OMZP::fzf
zinit snippet OMZP::command-not-found

autoload -Uz compinit && compinit

zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"

alias neofetch=fastfetch
alias ls=eza
alias ll="eza -lah"
alias neovide="neovide --neovim-bin $(which nvim)"

eval "$(zoxide init --cmd cd zsh)"

zvm_after_init_commands+=(
    'bindkey "^p" history-beginning-search-backward'
    'bindkey "^n" history-beginning-search-forward'
)
