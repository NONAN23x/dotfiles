const hyprland = await Service.import("hyprland")
const audio = await Service.import("audio")
const battery = await Service.import("battery")
const systemtray = await Service.import("systemtray")

const date = Variable("", {
    poll: [1000, 'date "+%I:%M %p"'],
})

const weather = Variable("", {
    // Poll every 10 minutes (600,000 milliseconds)
    poll: [600000, '/home/nonan23x/.config/ags/scripts/fetch_weather.sh'],
});
// widgets can be only assigned as a child in one container
// so to make a reuseable widget, make it a function
// then you can simply instantiate one by calling it
//

function StaticWorkspaces() {
    const activeId = hyprland.active.workspace.bind("id");
    const workspaceButtons = [];

    for (let i = 1; i <= 10; i++) {
        // Generate each workspace button
        const workspaceButton = Widget.Button({
            on_clicked: () => hyprland.messageAsync(`dispatch workspace ${i}`),
            child: Widget.Label(`${i}`),
            // Determine if this workspace is the active one and apply the "focused" class accordingly
            class_name: activeId.as(active => active === i ? "focused" : ""),
        });
        workspaceButtons.push(workspaceButton);
    }

    return Widget.Box({
        class_name: "workspaces",
        children: workspaceButtons,
        // Assuming horizontal layout for the workspace buttons; adjust as needed
        vertical: false,
    });
}

function ClientTitle() {
    return Widget.Label({
        class_name: "client-title",
        label: hyprland.active.client.bind("title"),
        maxWidthChars: 24,
        truncate: 'end',
        useMarkup: true,
    })
}

function Weather() {
  return Widget.Label({
    label: weather.bind(),
  })
}

function Clock() {
    return Widget.Label({
        class_name: "clock",
        label: date.bind(),
    })
}

function VolumeCircularProgress() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    };

    function getIcon() {
        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
            threshold => threshold <= audio.speaker.volume * 100);

        return `audio-volume-${icons[icon]}-symbolic`;
    }

    const volumeProgress = Widget.CircularProgress({
        class_name: "volume-circular-progress",
        rounded: true,
        value: audio.speaker.bind("volume"),
        child: Widget.Icon({
            icon: Utils.watch(getIcon(), audio.speaker, getIcon),
            size: 15,
         }),
        setup: self => {
            // Update the progress value and icon when the volume changes
            self.hook(audio.speaker, () => {
                self.value = audio.speaker.volume;
                // self.icon = getIcon();
            });
        },
    });

    // This icon represents the volume level and mute state, updated dynamically.
    const icon = Widget.Icon({
        icon: Utils.watch(getIcon(), audio.speaker, getIcon),
    });

    return Widget.Box({
        class_name: "volume-circular",
        children: [volumeProgress],
    });
}

function Volume() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    }

    function getIcon() {
        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
            threshold => threshold <= audio.speaker.volume * 100)

        return `audio-volume-${icons[icon]}-symbolic`
    }

    const icon = Widget.Icon({
        icon: Utils.watch(getIcon(), audio.speaker, getIcon),
    })
    
    const slider = Widget.Slider({
        class_name: "volume-slider",
        hexpand: true,
        draw_value: false,
        on_change: ({ value }) => audio.speaker.volume = value,
        setup: self => self.hook(audio.speaker, () => {
            self.value = audio.speaker.volume || 0
        }),
    })

    return Widget.Box({
        class_name: "volume",
        css: "min-width: 180px",
        children: [icon, slider],
    })
}


function BatteryLabel() {
    return Widget.CircularProgress({
        class_name: "battery-circular-progress",
        rounded: true,
        inverted: false,
        startAt: 0.75,
        value: battery.bind('percent').as(p => p / 100),
        child: Widget.Icon({
            icon: battery.bind('icon-name'),
            size: 15,
        }),
})
}


function SysTray() {
    const items = systemtray.bind("items")
        .as(items => items.map(item => Widget.Button({
            child: Widget.Icon({ icon: item.bind("icon") }),
            on_primary_click: (_, event) => item.activate(event),
            on_secondary_click: (_, event) => item.openMenu(event),
            tooltip_markup: item.bind("tooltip_markup"),
        })))

    return Widget.Box({
        children: items,
    })
}


// layout of the bar
function Left() {
    return Widget.Box({
        spacing: 8,
        children: [
            ClientTitle(),
        ],
    })
}

function Center() {
    return Widget.Box({
        spacing: 8,
        children: [
            StaticWorkspaces(),
        ],
    })
}

function Right() {
    return Widget.Box({
        hpack: "end",
        spacing: 8,
        children: [
            Weather(),
            VolumeCircularProgress(),
            BatteryLabel(),
            SysTray(),
            Clock(),
        ],
    })
}

function Bar(monitor = 0) {
    return Widget.Window({
        name: `bar-${monitor}`, // name has to be unique
        class_name: "bar",
        monitor,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        margins: [14, 24, 0, 24],
        child: Widget.CenterBox({
            start_widget: Left(),
            center_widget: Center(),
            end_widget: Right(),
        }),
    })
}


export { Bar }
