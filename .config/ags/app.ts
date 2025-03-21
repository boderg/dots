import { App, Widget } from "astal/gtk3"
// import Hyprland from "gi://AstalHyprland"
import style from "./styles/style.scss"
import Bar from "./widgets/Bar/Bar"
import Applauncher from "./widgets/Applauncher"

App.start({
    instanceName: "launcher, settings, powermenu",
    css: style,
    main() {    
        App.get_monitors().map(Bar),
        Applauncher
    },
})
