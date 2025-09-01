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

path_prepend() {
    for dir in "$@"; do
        [[ ":$PATH:" != *":$dir:"* ]] && PATH="$dir:$PATH"
    done
}

path_prepend "$HOME/.local/share/pnpm" \
    "$HOME/.local/share/bob/nvim-bin" \
    "$HOME/.local/bin"

export EDITOR=$(which nvim)
export VISUAL=$EDITOR

eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/catppuccin_mocha.omp.toml)"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1a --color=always $realpath'

autoload -Uz compinit && compinit

zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions 
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light jeffreytse/zsh-vi-mode

zinit ice lucid wait
zinit snippet OMZP::fzf
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

alias neofetch=fastfetch
alias ls=eza
alias ll="eza -lah"
alias neovide="neovide --neovim-bin $(which nvim)"
alias zshrc="${=EDITOR} ~/.zshrc"
alias clear=" clear"
alias exit=" exit"
alias pwd=" pwd"
alias rm="rm -iv"
alias mv="rm -iv"
alias cp="cp -iv"

y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d "" cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

backward-delete-word() {
    local WORDCHARS=""
    zle backward-kill-word
}
zle -N backward-delete-word

backward-delete-whole-word() {
    local WORDCHARS=$WORDCHARS
    [[ ! $WORDCHARS == *":"* ]] && WORDCHARS="$WORDCHARS"":"
    zle backward-kill-word
}
zle -N backward-delete-whole-word

zvm_after_init_commands+=(
    "bindkey '^P' history-beginning-search-backward"
    "bindkey '^N' history-beginning-search-forward"
    "bindkey '^W' backward-delete-word"
    "bindkey '^[^W' backward-delete-whole-word"
)

eval "$(zoxide init --cmd cd zsh)"
