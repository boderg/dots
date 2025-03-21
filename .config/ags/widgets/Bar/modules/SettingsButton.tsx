import Settings from "../../Settings/Settings";

export default function SettingsButton() {
    
    return (
        <button 
            className="SettingsButton" 
            onClicked={Settings} >
            <icon 
                icon={"emblem-system"} />
        </button>
    )
}