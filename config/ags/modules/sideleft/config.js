const WINDOW_NAME = "sideleft"

function myLabel() {
    return Widget.Label({
        label: "Hello World",
    })
}

function Quicksettings() {
    return Widget.Window({
        name: `sideleft`,
        class_name: "quicksettings",
        anchor: ["left", "top", "bottom"],
        margins: [8, 8, 8, 8],
        visible: false,
        setup: self => self.keybind("Escape", () => {
            App.closeWindow(WINDOW_NAME)
        }),
        child: Widget.Box({
            // setup: self => self.hook(App, (_, windowName, visible) => {
            //     if (windowName !== WINDOW_NAME)
            //         return
    
            //     // when the applauncher shows up
            //     if (visible) {
            //         entry.text = ""
            //         entry.grab_focus()
            //     }
            // }),
            children: [
                myLabel(),
            ]
        })

    })
}

export { Quicksettings }