import { App, Astal, Gdk, Gtk } from "astal/gtk3"
import { GLib, Variable } from "astal"
import { exec } from "astal/process"

const lock = () => {
    exec("hyprlock")// Lock the computer
  }
const logout = () => {
    exec("hyprctl dispatch exit")// Logout the user
  }
const restart = () => {
    exec("systemctl reboot")// Restart the computer
  }
const shutdown = () => {
    exec("systemctl poweroff")// Shutdown the computer
  }

function hide() {
    App.get_window("powermenu")!.hide()
}

export default function Power() {
  const { CENTER, START, END } = Gtk.Align
  const width = Variable(1000)
  const text = Variable("")
  
  return (
    <window
      name="powermenu"
      setup={self => App.add_window(self)}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM}
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
                            heightRequest={700} 
                            onClick={hide} />
                            <box
                              hexpand={false} 
                                vertical
                                widthRequest={300} 
                                className="PowerMenu" 
                                spacing={6} >
                                  <box 
                                      halign={ CENTER }>
                                      <label>
                                          Power Menu
                                      </label>
                                  </box>
                                  <box
                                    halign={ CENTER }
                                    spacing={6} >
                                    <button 
                                        onClick={lock} >
                                        <icon 
                                            icon={"system-lock-screen"} />
                                        </button>
                                    <button 
                                        onClick={logout} >
                                        <icon 
                                            icon={"system-log-out"} />
                                    </button>
                                    <button 
                                        onClick={restart} >
                                        <icon 
                                            icon={"edit-redo"} />
                                    </button>
                                    <button 
                                        onClick={shutdown} >
                                        <icon 
                                            icon={"system-shutdown"} />
                                    </button>
                                  </box>
                            </box>
                        <eventbox 
                            heightRequest={50}
                            expand 
                            onClick={hide} />
                  </box>
              <eventbox 
                  widthRequest={width(w => w / 2)}
                  expand 
                  onClick={hide} />
            </box>
        </window>
    )
}