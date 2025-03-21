import { execAsync } from "astal/process"

export default function Hyprpicker() {
  const hyprpicker = () => execAsync("hyprpicker -a -f hex")
    
    return (
        <button
            className="Hyprpicker" 
            onClicked={hyprpicker} >
              <icon icon="colors-luma" />
        </button>
    )
}