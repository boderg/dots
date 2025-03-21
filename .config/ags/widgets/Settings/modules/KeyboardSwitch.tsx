import { exec } from "astal/process"

export default function KeyboardSwitch() {
  const keyboard_switch = () => exec("/home/simon/.config/ags/scripts/switch_keyboard_layout.sh")
    
    return (
        <button
            className="KeyboardSwitch" 
            onClicked={keyboard_switch} >
              <icon icon="input-keyboard" />
        </button>
    )
}
