import { bind } from "astal"
import Wp from "gi://AstalWp"
import Variable from "astal/variable"

export default function Volume() {
    const speaker = Wp.get_default()?.get_default_speaker()
    const volumeLabel = Variable("")
    speaker.connect("notify::volume", () =>
        volumeLabel.set(`${Math.floor(speaker.volume * 100)}%`)
    )
    volumeLabel.set(`${Math.floor(speaker.volume * 100)}%`) // Initialize value

    return (
        <box>
            <icon 
                icon={bind(speaker, "volumeIcon")} />
            <label 
                label={volumeLabel()} />
        </box>
    )
}