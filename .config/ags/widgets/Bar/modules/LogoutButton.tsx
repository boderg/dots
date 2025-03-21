import Power from '../../Power'

export default function LogoutButton() {
    // const wlogout = 'wlogout -p layer-shell -n -b 4 -c 20 -r 0 -m 0 -T 1050 -B 300 -R 1500 -L 1500'
  
    return (
        <button 
            className="LogoutButton" 
            onClicked={Power}>
            <icon 
                icon={"system-shutdown"} />
        </button>
    )
}