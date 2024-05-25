import { Bar } from './modules/bar/config.js'
import { Quicksettings } from './modules/sideleft/config.js'


App.config({
    style: "./style.css",
    windows: [
        Bar(),
        Quicksettings(),
    ],
})

