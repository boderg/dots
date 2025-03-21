import { exec, execAsync } from "astal/process"
import { Variable, bind } from "astal"

// Reactive variable for color temperature (default: 5500K)
const colorTemp = Variable(3000)

// Function to set color temperature
const setColorTemp = (value: number) => {
    execAsync(`hyprsunset -t ${value}`)
}

// Hyprsunset Component
export default function Hyprsunset() {
    return (
        <box className="HyprsunsetSlider" css="min-width: 140px">
            <icon icon="preferences-desktop-display" />
            <slider
                hexpand
                min={3000}
                max={8000}
                step={100}
                value={bind(colorTemp)} 
                onDragged={({ value }) => {
                    colorTemp.set(value)
                    setColorTemp(value)
                }}
            />
        </box>
    )
}
