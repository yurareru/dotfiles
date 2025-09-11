path_prepend() {
    for dir in "$@"; do
        [[ ":$PATH:" != *":$dir:"* ]] && PATH="$dir:$PATH"
    done
}

path_prepend "$HOME/.local/share/pnpm" \
    "$HOME/.local/share/bob/nvim-bin" \
    "$HOME/.local/bin"

export PNPM_HOME="$HOME/.local/share/pnpm"
export EDITOR="$(which nvim)"
export VISUAL="$EDITOR"
export TERM=xterm-kitty
export TERMINAL=$TERM
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export LIBVIRT_DEFAULT_URI="qemu:///system"
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space incappendhistory hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups
setopt auto_param_slash
setopt no_case_glob no_case_match
setopt globdots

eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/catppuccin_mocha.omp.toml)"

zle-line-init() {
  echo -ne '\e[5 q'
}
zle -N zle-line-init

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ":completion:*:git-checkout:*" sort false
zstyle ":fzf-tab:complete:cd:*" fzf-preview "eza -1a --color=always $realpath"

autoload -U compinit; compinit

zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions 
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light akash329d/zsh-alias-finder
zinit light mattmc3/zsh-safe-rm

zinit snippet OMZP::fzf
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::systemd
zinit snippet OMZP::command-not-found

alias ls=eza
alias ll="eza -lah"
alias grep="grep --color=auto"
alias neovide="neovide --neovim-bin $(which nvim)"
alias zshrc="${=EDITOR} ~/.zshrc"
alias clear=" clear"
alias exit=" exit"
alias pwd=" pwd"
alias neofetch=" fastfetch"

y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d "" cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}
zle -N y

backward-delete-word() {
    local WORDCHARS=""
    zle backward-kill-word
}
zle -N backward-delete-word

bindkey -e
# mimic vim keybindings
bindkey "^[w" forward-word
bindkey "^[e" vi-forward-word-end
bindkey "^[0" beginning-of-line
bindkey "^[4" end-of-line
bindkey "^W" backward-delete-word
bindkey "^[h" backward-char
bindkey "^[l" forward-char

bindkey "^E" y
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

eval "$(zoxide init --cmd cd zsh)"
