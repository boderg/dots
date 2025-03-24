import { App, Widget } from "astal/gtk3"
// import Hyprland from "gi://AstalHyprland"
import style from "./styles/style.scss"
import Bar from "./widgets/Bar/Bar"
import Applauncher from "./widgets/Applauncher"
import NotificationPopups from "./widgets/notifications/NotificationPopups" 
// import MprisPlayers from "./widgets/MediaPlayer"

App.start({
    // instanceName: ("launcher, settings"),
    icons: '/home/simon/.local/share/icons',
    css: style,
    main:() => {    
        App.get_monitors().map(Bar),
        App.get_monitors().map(NotificationPopups),
        // new Widget.Window({}, MprisPlayers()),
        Applauncher
    },
})
