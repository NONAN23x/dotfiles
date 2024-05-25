#!/usr/bin/bash


# ██╗    ██╗ █████╗ ██╗     ██╗     ██████╗  █████╗ ██████╗ ███████╗██████╗ 
# ██║    ██║██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
# ██║ █╗ ██║███████║██║     ██║     ██████╔╝███████║██████╔╝█████╗  ██████╔╝
# ██║███╗██║██╔══██║██║     ██║     ██╔═══╝ ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
# ╚███╔███╔╝██║  ██║███████╗███████╗██║     ██║  ██║██║     ███████╗██║  ██║
#  ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
# setting a wallpaper
if [ "$1" == "--noswitch" ]; then
    imgpath=$(swww query | awk -F 'image: ' '{print $2}')
else
    cd "$HOME/Pictures/Wallpapers"
    imgpath=$(yad --width 1200 --height 800 --file --title='Choose wallpaper')
    screensizey=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2 | head -1)
    # cursorposx=$(hyprctl cursorpos -j | gojq '.x' 2>/dev/null) || cursorposx=960
    # cursorposy=$(hyprctl cursorpos -j | gojq '.y' 2>/dev/null) || cursorposy=540
    # cursorposy_inverted=$(( screensizey - cursorposy ))

    if [ "$imgpath" == '' ]; then
        echo 'Aborted'
        exit 0
    fi

    swww img "$imgpath" --transition-step 100 --transition-fps 60 \
    --transition-type any --transition-duration 2
    # ██████╗ ██╗   ██╗██╗    ██╗ █████╗ ██╗     
    # ██╔══██╗╚██╗ ██╔╝██║    ██║██╔══██╗██║     
    # ██████╔╝ ╚████╔╝ ██║ █╗ ██║███████║██║     
    # ██╔═══╝   ╚██╔╝  ██║███╗██║██╔══██║██║     
    # ██║        ██║   ╚███╔███╔╝██║  ██║███████╗
    # ╚═╝        ╚═╝    ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝
    # pywal
    wal -q -e -i ${imgpath} 
    rm $HOME/.wallpapers/currentWall
    rm ~/.cache/wallPath
    ln -s ${imgpath} $HOME/.wallpapers/currentWall
    echo "${imgpath}" > ~/.cache/wallPath
    pywal-discord
    
    
    # ███╗   ███╗ ██████╗ ███╗   ██╗███████╗████████╗
    # ████╗ ████║██╔═══██╗████╗  ██║██╔════╝╚══██╔══╝
    # ██╔████╔██║██║   ██║██╔██╗ ██║█████╗     ██║   
    # ██║╚██╔╝██║██║   ██║██║╚██╗██║██╔══╝     ██║   
    # ██║ ╚═╝ ██║╚██████╔╝██║ ╚████║███████╗   ██║   
    # ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝   ╚═╝
    flatpak run --command=gradience-cli com.github.GradienceTeam.Gradience access-file --allow ${imgpath}
    flatpak run --command=gradience-cli com.github.GradienceTeam.Gradience monet -n "pywal" -p ${imgpath} --theme dark
    flatpak run --command=gradience-cli com.github.GradienceTeam.Gradience apply -n "pywal"
    flatpak run --command=gradience-cli com.github.GradienceTeam.Gradience flatpak-overrides -e both
    # killall ags && ags & disown
    sleep 1 && killall swaync && swaync & disown
    # ags run-js 'openColorScheme.value = true; Utils.timeout(2000, () => openColorScheme.value = false);'
    #
    ags run-js "App.resetCss(); App.applyCss('${HOME}/.config/ags/style.css');"

    # Rofi colors
    convert ~/.wallpapers/currentWall -crop 1920x1200+800+500 ~/.config/rofi/bannerImage.jpg


fi


