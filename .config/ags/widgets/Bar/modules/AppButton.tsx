import { GLib } from "astal"
import Applauncher from "../../Applauncher"

export default function AppButton() {
    
    return (  
        <button 
            className="AppButton" 
            onClicked={Applauncher}>
            <icon 
                icon={GLib.get_os_info("LOGO") || "missing-symbolic"} />
        </button>
    )
}