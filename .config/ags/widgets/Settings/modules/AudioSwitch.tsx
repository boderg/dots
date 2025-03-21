export default function AudioSwitch() {
    const audio_switch = "/home/simon/.config/scripts/select_audio_sink.sh"
  
    return (
        <button
            className="AudioSwitch"
            onClicked={audio_switch}>
            <icon 
                icon="audio-card" />
        </button>
    )
}