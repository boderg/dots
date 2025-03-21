import { bind } from "astal"
import Wp from "gi://AstalWp"

export default function MicSlider() {
    const microphone = Wp.get_default()?.audio.defaultMicrophone!

    return (
        <box 
            className="MicSlider" css="min-width: 140px">
            <icon 
                icon={bind(microphone, "volumeIcon")} />
            <slider
                hexpand
                onDragged={({ value }) => microphone.volume = value}
                value={bind(microphone, "volume")}
            />
        </box>
    )
}