import { App, Astal, Gdk, Gtk, Widget } from "astal/gtk3"
import { Variable, GLib } from "astal"
import AudioSlider from "./modules/AudioSlider"
import AudioSwitch from "./modules/AudioSwitch"
import Hyprpicker from "./modules/Hyprpicker"
import Hyprshot from "./modules/Hyprshot"
import Hyprsunset from "./modules/Hyprsunset"
import KeyboardSwitch from "./modules/KeyboardSwitch"
import MicSlider from "./modules/MicrophoneSlider"
import SysTray from "./modules/SysTray"
import Time from "./../Bar/modules/Time"
import Media from "./../Bar/modules/Media"
import Weather from "./modules/Weather"

function hide() {
    App.get_window("settings")!.hide()
}

export default function Settings() {
    const { CENTER, START, END } = Gtk.Align
    const width = Variable(1000)
    const text = Variable("")
  
    return (
        <window
            name="settings"
            anchor={Astal.WindowAnchor.BOTTOM|Astal.WindowAnchor.RIGHT}
            exclusivity={Astal.Exclusivity.IGNORE}
            keymode={Astal.Keymode.ON_DEMAND}
            application={App}
            onShow={(self) => {
                text.set("")
                width.set(self.get_current_monitor().workarea.width)
            }}
            onKeyPressEvent={function (self, event: Gdk.Event) {
                if (event.get_keyval()[1] === Gdk.KEY_Escape)
                    self.hide()
            }}>
              <box>
                  <eventbox
                      widthRequest={width(w => w / 2)} 
                      expand 
                      onClick={hide} />
                      <box
                          hexpand={false}
                          vertical >
                            <eventbox 
                                heightRequest={100} 
                                onClick={hide} />
                                <box
                                    hexpand={false} 
                                    vertical
                                    widthRequest={300} 
                                    className="Settings" 
                                    spacing={12} >
                                        <Time />
                                    <box
                                        halign={CENTER} >
                                        <Weather />
                                    </box>
                                    <label 
                                        halign={START} > 
                                        Volume
                                    </label>
                                        <AudioSlider />
                                    <label 
                                        halign={START} > 
                                        Microphone
                                    </label>
                                        <MicSlider />
                                    <label
                                        halign={CENTER} >
                                        Tools
                                    </label>
                                    <box 
                                      halign={ CENTER } >
                                        <AudioSwitch />
                                        <KeyboardSwitch />
                                        <Hyprpicker />
                                    </box>
                                    <label 
                                        halign={CENTER} > 
                                        Hyprshot
                                    </label>
                                    <box 
                                      halign={CENTER} > 
                                        <Hyprshot />
                                    </box>
                                    <label 
                                        halign={START} > 
                                        Color Temperature
                                    </label>
                                        <Hyprsunset />
                                    <label
                                        halign={CENTER} >
                                        System Tray
                                    </label>
                                    <box 
                                        halign={CENTER} >
                                        <SysTray />
                                    </box>
                                    <label 
                                        halign={CENTER} > 
                                        Media Now Playing
                                    </label>
                                    <box 
                                        halign={CENTER} > 
                                        <Media />
                                    </box>
                                </box>
                            <eventbox 
                                heightRequest={50}
                                expand 
                                onClick={hide} />
                      </box>
                  <eventbox 
                      expand 
                      onClick={hide} />
              </box>
        </window>
    )
}