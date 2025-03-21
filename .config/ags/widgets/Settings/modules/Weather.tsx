import { exec } from "astal/process"

export default function Weather() {
    const weather_yad = "/home/simon/.config/scripts/weather_yad.sh"
    const weather = exec("/home/simon/.config/ags/scripts/weather.sh")
    
    return (
        <button
            className="Weather" 
            onClicked={weather_yad}
            label={weather}>
        </button>
    )
}