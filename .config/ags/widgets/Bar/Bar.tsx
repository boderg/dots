import { App, Astal, Gtk, Gdk } from "astal/gtk3"

import AppButton from "./modules/AppButton"
// import AudioSwitch from "./modules/AudioSwitch"
import FocusedClient from "./modules/FocusedClient"
import LogoutButton from "./modules/LogoutButton"
import Media from "./modules/Media"
import SettingsButton from "./modules/SettingsButton"
// import SysTray from "./modules/SysTray"
import Time from "./modules/Time"
import Volume from "./modules/Volume"
// import Weather from "../Settings/modules/Weather"
import Workspaces from "./modules/Workspaces"


export default function Bar(monitor: Gdk.Monitor) {
    const { BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor

    return ( 
        <window
            className="Bar"
            gdkmonitor={monitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={BOTTOM | LEFT | RIGHT} >
            <centerbox>
                <box 
                    hexpand halign={Gtk.Align.START} >
                        <AppButton />
                        <Workspaces />
                        <FocusedClient />
                </box>
                <box>
                        <Time />
                        {/* <Weather /> */}
                </box>
                <box 
                    hexpand halign={Gtk.Align.END} >
                        <Media />
                        {/* <SysTray /> */}
                        <Volume />
                        <SettingsButton />
                        {/* <AudioSwitch /> */}
                        <LogoutButton />
                        {/* <Wifi /> */}
                        {/* <AudioSlider /> */}
                        {/* <BatteryLevel /> */}
                </box>
            </centerbox>
        </window>
    )
}