if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
end

starship init fish | source

# Aliases
alias joke="fortune | cowsay | lolcat"
alias vim=nvim
alias ls=lsd
alias neofetch="neofetch --source ~/.config/neofetch/images/"
alias sudo='doas'
alias sudoedit='doas rnano'
    
# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment
    
# Locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Exports
export VISUAL="vim"
export EDITOR="$VISUAL"
export CHROME_EXECUTABLE=google-chrome-stable # for flutter

# User abbreviations
abbr -a -g ytmp3 'youtube-dl --extract-audio --audio-format mp3'				# Convert/Download YT videos as mp3
abbr -a -g genpass 'openssl rand -base64 20'													# Generate a random, 20-charactered password

pokemon-colorscripts -r --no-title
wal -q -e -n -i ~/.wallpapers/currentWall

