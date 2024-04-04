import { Bar } from './modules/bar/config.js'
import { applauncher } from './modules/launcher/applauncher.js'

App.config({
    style: "./style.css",
    windows: [
        Bar(),
        applauncher,
    ],
})

