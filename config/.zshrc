# --- 1. Environment & Path Management ---
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Source/Load zinit
if [[ -f "${ZINIT_HOME}/zinit.zsh" ]]; then
    source "${ZINIT_HOME}/zinit.zsh"
else
    # Auto-install zinit if missing
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    source "${ZINIT_HOME}/zinit.zsh"
fi

# --- 2. Plugins & Snippets (Zinit - Turbo Loaded) ---
# Load completions immediately but fast
zinit light zsh-users/zsh-completions

# Turbo load OMZ snippets and heavy plugins (loads in background after prompt)
zinit wait lucid for \
    OMZL::git.zsh \
    OMZP::git \
    OMZP::sudo \
    OMZP::archlinux \
    OMZP::command-not-found \
    zsh-users/zsh-autosuggestions \
    Aloxaf/fzf-tab

# Syntax highlighting MUST be the absolute last thing loaded
zinit wait lucid for zsh-users/zsh-syntax-highlighting

# Load completions intelligently (skip security checks if cache exists)
autoload -Uz compinit
if [[ -f ~/.zcompdump ]]; then
    compinit -C
else
    compinit
fi
zinit cdreplay -q

# --- 3. Shell Options & History ---
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE

# Consolidated History Options
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_reduce_blanks
setopt hist_find_no_dups

# General Zsh Options
setopt AUTO_CD              # cd by typing directory name
setopt nomatch              # error if pattern has no match
setopt interactivecomments  # allow comments in interactive shell

# --- 4. Keybindings ---
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
# Home key
bindkey "^[[1~" beginning-of-line
bindkey "^[[H"  beginning-of-line
bindkey "\e[H"  beginning-of-line
bindkey "\eOH"  beginning-of-line
# End key
bindkey "^[[4~" end-of-line
bindkey "^[[F"  end-of-line
bindkey "\e[F"  end-of-line
bindkey "\eOF"  end-of-line

# --- 5. Completions & FZF Styling ---
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# FZF-Tab configuration
zstyle ':fzf-tab:*' fzf-flags --preview-window=right:60%
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'ls -1 --color=always $realpath'
zstyle ':fzf-tab:complete:cp:*' fzf-preview 'ls -1 --color=always $realpath'
zstyle ':fzf-tab:complete:mv:*' fzf-preview 'ls -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls -1 --color=always $realpath'

# --- 6. Aliases & Exports ---
export MANPAGER='nvim +Man!'
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
export ANDROID_HOME=$HOME/Android/Sdk

# Update Path (Unique entries)
path+=(
    ~/.local/bin
    $ANDROID_HOME/cmdline-tools/latest/bin
    $ANDROID_HOME/build-tools/36.1.0
    $ANDROID_HOME/platform-tools
    /opt/flutter/bin
)

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias ff="fzf --style full --preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'"
alias grep='grep --color=auto'

# --- 7. Shell Integrations ---
# Load prompt immediately
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/uew.conf.toml)"

# Lazy-load heavy integrations (initialized on first use)
zoxide() { unfunction zoxide; eval "$(zoxide init zsh)"; zoxide "$@" }
fzf() { unfunction fzf; eval "$(fzf --zsh)"; fzf "$@" }


# --- 8. Visual Extras ---
# Run this at the very end to not delay prompt appearance
pokemon-colorscripts -r --no-title
