# --- 0. System Config (CachyOS) ---
# if [[ -f /usr/share/cachyos-zsh-config/cachyos-config.zsh ]]; then
#    source /usr/share/cachyos-zsh-config/cachyos-config.zsh
# fi

# --- 1. Environment & Path Management ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ -f "${ZINIT_HOME}/zinit.zsh" ]]; then
    source "${ZINIT_HOME}/zinit.zsh"
else
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    source "${ZINIT_HOME}/zinit.zsh"
fi

# --- 2. Plugins & Snippets ---
# Keep autosuggestions readable across light and dark terminal themes.
typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan,italic'
zinit light zsh-users/zsh-completions

zinit light zsh-users/zsh-autosuggestions
zinit wait lucid for Aloxaf/fzf-tab

zinit wait lucid for zsh-users/zsh-syntax-highlighting

autoload -Uz compinit
if [[ -f ~/.zcompdump ]]; then
    compinit -C
else
    compinit
fi
zinit cdreplay -q

# --- 3. Shell Options & History ---
HISTSIZE=100000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_reduce_blanks
setopt hist_find_no_dups

setopt AUTO_CD
setopt nomatch
setopt interactivecomments

# --- 4. Keybindings ---
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1~" beginning-of-line
bindkey "^[[H"  beginning-of-line
bindkey "\e[H"  beginning-of-line
bindkey "\eOH"  beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[F"  end-of-line
bindkey "\e[F"  end-of-line
bindkey "\eOF"  end-of-line

# --- 5. Completions & FZF Styling ---
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

zstyle ':fzf-tab:*' fzf-flags --preview-window=right:60%
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --all --color=always --group-directories-first --icons=auto $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'eza --all --color=always --group-directories-first --icons=auto $realpath'
zstyle ':fzf-tab:complete:cp:*' fzf-preview 'eza --all --color=always --group-directories-first --icons=auto $realpath'
zstyle ':fzf-tab:complete:mv:*' fzf-preview 'eza --all --color=always --group-directories-first --icons=auto $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --all --color=always --group-directories-first --icons=auto $realpath'

# --- 6. Aliases & Exports ---
export MANPAGER='nvim +Man!'
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
export ANDROID_HOME=$HOME/Android/Sdk

path+=(
    ~/.local/bin
    ~/.bun/bin
    $ANDROID_HOME/cmdline-tools/latest/bin
    $ANDROID_HOME/build-tools/37.0.0
    $ANDROID_HOME/platform-tools
    /home/nonan23x/Projects/flutter/bin
    /home/nonan23x/.opencode/bin
    /home/nonan23x/.cargo/bin

)

alias ls='eza --group-directories-first --icons=auto'
alias ll='eza -lh --group-directories-first --icons=auto'
alias la='eza -lAh --group-directories-first --icons=auto'
alias ff="fzf --style full --preview '~/.local/bin/fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'"
alias grep='grep --color=auto'

# --- 7. Shell Integrations ---
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/mytheme.omp.toml)"
eval "$(zoxide init zsh)"

fzf() { unfunction fzf; eval "$(fzf --zsh)"; fzf "$@" }

function y() {
    local tmp cwd
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")" || return
    command yazi "$@" --cwd-file="$tmp"
    cwd="$(<"$tmp")"
    [[ -n "$cwd" && "$cwd" != "$PWD" ]] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# --- 8. Visual Extras ---
if [[ -z "$TMUX" && "${SHLVL:-1}" -eq 1 ]]; then
    pokemon-colorscripts -r --no-title
fi

#export CODEX_CLI_PATH=/usr/bin/codex

alias vi=nvim
