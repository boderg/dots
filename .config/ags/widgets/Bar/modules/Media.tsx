import { bind } from "astal"
import Mpris from "gi://AstalMpris"
import { Gtk } from "astal/gtk3"

export default function Media() {
    const mpris = Mpris.get_default()

    return (
        <box 
            className="Media">
            {bind(mpris, "players").as(ps => ps[0] ? (
                <box>
                    <box
                        className="Cover"
                        valign={Gtk.Align.CENTER}
                        css={bind(ps[0], "coverArt").as(cover =>
                        `background-image: url('${cover}') ? cover : "vinyl";`
                        )}
                    />
                    <label
                        label={bind(ps[0], "metadata").as(metadata =>
                        metadata ? `${ps[0].title ?? "Unknown Title"}  ${ps[0].artist ?? "Unknown Artist"}` : " "
                        )}
                    />
                </box>
            ) : (
                <label 
                    label=" " />
                ))}
        </box>
    )
}