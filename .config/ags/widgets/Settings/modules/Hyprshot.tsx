import { execAsync } from "astal/process"

export default function Hyprshot() {
  const hyprshot_window = () => execAsync("hyprshot -m window")
  const hyprshot_output = () => execAsync("hyprshot -m output")
  const hyprshot_region = () => execAsync("hyprshot -m region")
    
    return (
        <box>
            <box
                vertical > 
                <button
                    className="Hyprshot" 
                    onClicked={hyprshot_window} >
                      <icon icon="camera-photo" />
                </button>
                      <label label="Window" />
              </box>
            <box
                vertical >
                <button
                    className="Hyprshot" 
                    onClicked={hyprshot_region} >
                      <icon icon="camera-photo" />
                </button>
                      <label label="Region" />
            </box>
            <box
              vertical >
                <button
                    className="Hyprshot" 
                    onClicked={hyprshot_output} >
                      <icon icon="camera-photo" />
                </button>
                      <label label="Output" />
            </box>
        </box>
    )
}