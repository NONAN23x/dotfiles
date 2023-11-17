export const keybindList = [[
    {
        "icon": "pin_drop",
        "name": "Workspaces: navigation",
        "binds": [
            { "keys": ["", "+", "#"], "action": "Go to workspace #" },
            { "keys": ["", "+", "S"], "action": "Take a Screenshot" },
            { "keys": ["", "+", "(Scroll ↑↓)"], "action": "Go to workspace -1/+1" },
        ],
        "appeartick": 1
    },
    {
        "icon": "overview_key",
        "name": "Workspaces: management",
        "binds": [
            { "keys": ["", "Shift", "+", "#"], "action": "Move window to workspace #" },
            { "keys": ["", "Shift", "+", "S"], "action": "Move window to special workspace" },
            { "keys": ["", "Shift", "+", "PageUp"], "action": "Move window to workspace on the left" },
            { "keys": ["", "Shift", "+", "PageDown"], "action": "Move window to workspace on the right" }
        ],
        "appeartick": 1
    },
    {
        "icon": "move_group",
        "name": "Windows",
        "binds": [
            { "keys": ["", "+", "←↑→↓"], "action": "Focus window in direction" },
            { "keys": ["", "Shift", "+", "←↑→↓"], "action": "Swap window in direction" },
            { "keys": ["", "+", ";"], "action": "Split ratio -" },
            { "keys": ["", "+", "'"], "action": "Split ratio +" },
            { "keys": ["", "+", "Lmb"], "action": "Move window" },
            { "keys": ["", "+", "Mmb"], "action": "Move window" },
            { "keys": ["", "+", "Rmb"], "action": "Resize window" },
            { "keys": ["", "+", "F"], "action": "Fullscreen" },
            { "keys": ["", "Alt", "+", "F"], "action": "Fake fullscreen" }
        ],
        "appeartick": 1
    }
],
[
    {
        "icon": "widgets",
        "name": "Widgets (AGS)",
        "binds": [
            { "keys": [""], "action": "Toggle overview/launcher" },
            { "keys": ["Ctrl", "", "+", "R"], "action": "Restart AGS" },
            { "keys": ["", "+", "/"], "action": "Toggle this cheatsheet" },
            { "keys": ["", "+", "O"], "action": "Toggle sidebar" },
            { "keys": ["", "+", "K"], "action": "Toggle virtual keyboard" },
            { "keys": ["Ctrl", "Alt", "+", "Del"], "action": "Power/Session menu" },

            { "keys": ["ALT", "+", "Q"], "action": "Exit a window" },
            { "keys": ["ESC"], "action": "Dismiss/close sidebar" },

            { "keys": ["Ctrl", "", "+", "T"], "action": "Change wallpaper+colorscheme" },

            // { "keys": ["", "+", "B"], "action": "Toggle left sidebar" },
            // { "keys": ["", "+", "N"], "action": "Toggle right sidebar" },
            // { "keys": ["", "+", "G"], "action": "Toggle volume mixer" },
            // { "keys": ["", "+", "M"], "action": "Toggle useless audio visualizer" },
            // { "keys": ["(right)Ctrl"], "action": "Dismiss notification & close menus" }
        ],
        "appeartick": 2
    },
    {
        "icon": "construction",
        "name": "Utilities",
        "binds": [
            { "keys": ["", "Shift", "+", "S"], "action": "Screen snip  >>  clipboard" },
            { "keys": ["", "Shift", "+", "T"], "action": "Image to text  >>  clipboard" },
            { "keys": ["", "Shift", "+", "C"], "action": "Color picker" },
            { "keys": ["", "Alt", "+", "R"], "action": "Record region" },
            { "keys": ["Ctrl", "Alt", "+", "R"], "action": "Record region with sound" },
            { "keys": ["", "Shift", "Alt", "+", "R"], "action": "Record screen with sound" }
        ],
        "appeartick": 2
    },
    // {
    //     "icon": "edit",
    //     "name": "Edit mode",
    //     "binds": [
    //         { "keys": ["Esc"], "action": "Exit Edit mode" },
    //         { "keys": ["#"], "action": "Go to to workspace #" },
    //         { "keys": ["Alt", "+", "#"], "action": "Dump windows to workspace #" },
    //         { "keys": ["Shift", "+", "#"], "action": "Swap windows with workspace #" },
    //         { "keys": ["Lmb"], "action": "Move window" },
    //         { "keys": ["Mmb"], "action": "Move window" },
    //         { "keys": ["Rmb"], "action": "Resize window" }
    //     ],
    //     "appeartick": 2
    // }
],
[
    {
        "icon": "apps",
        "name": "Apps",
        "binds": [
            { "keys": ["", "+", "Q"], "action": "Launch terminal: Kitty" },
            { "keys": ["", "+", "B"], "action": "Launch browser: Google Chrome" },
            { "keys": ["", "+", "C"], "action": "Launch Calculator: GNOME Calculator" },
            { "keys": ["", "+", "R"], "action": "Launch File Manager: GNOME Files" },
        ],
        "appeartick": 3
    },
    {
        "icon": "keyboard",
        "name": "Typing",
        "binds": [
            { "keys": ["", "+", "V"], "action": "Clipboard history  >>  clipboard" },
            { "keys": ["", "+", "."], "action": "Emoji picker  >>  clipboard" },
        ],
        "appeartick": 3
    },
    {
        "icon": "terminal",
        "name": "Launcher commands",
        "binds": [
            { "keys": [">raw"], "action": "Toggle mouse acceleration" },
            { "keys": [">img"], "action": "Select wallpaper and generate colorscheme" },
            { "keys": [">light"], "action": "Use light theme for next color generations" },
            { "keys": [">dark"], "action": "Use dark theme for next color generations" },
            { "keys": [">todo"], "action": "Type something after that to add a To-do item" },
        ],
        "appeartick": 3
    }
]];
