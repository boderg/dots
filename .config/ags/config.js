import { applauncher } from "./launcher/applauncher.js"
import { Bar } from "./bar/bar.js"
import { Media } from "./media/media.js"
// import { NotificationPopups } from "./notification/notification.js"

// const win = Widget.Window({
//     name: "mpris",
//     anchor: ["top", "right"],
//     child: Media(),
// })

// Utils.timeout(100, () => Utils.notify({
//     summary: "Notification Popup Example",
//     iconName: "info-symbolic",
//     body: "Lorem ipsum dolor sit amet, qui minim labore adipisicing "
//         + "minim sint cillum sint consectetur cupidatat.",
//     actions: {
//         "Cool": () => print("pressed Cool"),
//     },
// }))

App.config({
    style: "./style.css",
    windows: [
        Bar(),
        applauncher,
        // NotificationPopups(),
        // win,
        // you can call it, for each monitor
        // Bar(0),
        // Bar(1)
    ],
    gtkTheme: "Andromeda",
})
