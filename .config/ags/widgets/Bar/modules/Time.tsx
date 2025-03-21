// import { Variable, GLib } from "astal"

// export default function Time({ format = "%H:%M" }) {
//     const time = Variable<string>("").poll(1000, () =>
//         GLib.DateTime.new_now_local().format(format)!)

//     return (
//         <label
//             className="Time"
//             onDestroy={() => time.drop()}
//             label={time()}
//         />
//     )       
// }


import {Variable} from "astal"

const date = Variable("").poll(30000, 'date "+%e/%m/%Y"')
const time = Variable("").poll(1000, 'date "+%H:%M"')

export default () => {
  return <centerbox
        name="clock"
        orientation={ 1 }
        startWidget={<label label={time()} />}
        endWidget={<label label={date()} />} >
    </centerbox>
}