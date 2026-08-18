import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import "../config.js" as Config

Rectangle {
    id: root

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property var source: Pipewire.defaultAudioSource

    readonly property int vol: sink?.ready ? Math.round(sink.audio.volume * 100) : 0

    readonly property int sourceVol: source?.ready ? Math.round(source.audio.volume * 100) : 0

    readonly property string icon: {
        if (!sink?.ready || vol === 0)
            return "󰖁";

        if (sink.audio.muted)
            return "󰝟";

        if (vol < 30)
            return "󰕿";

        if (vol < 60)
            return "󰖀";

        return "󰕾";
    }

    implicitWidth: row.implicitWidth + 24
    implicitHeight: 34

    radius: 10
    color: Config.colors.base

    Row {
        id: row
        spacing: 20
        anchors.centerIn: parent

        Item {
            implicitWidth: sinkText.implicitWidth
            implicitHeight: 34

            Text {
                id: sinkText
                anchors.centerIn: parent

                text: `${root.icon} ${root.sink?.audio?.muted ? "Muted" : root.vol + "%"}`
                color: Config.colors.blue

                font {
                    family: "JetBrainsMono Nerd Font"
                    pixelSize: 16
                    bold: true
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: root.sink.audio.muted = !root.sink.audio.muted
                onWheel: e => root.sink.audio.volume += (e.angleDelta.y > 0 ? 0.05 : -0.05)
            }
        }

        Item {
            implicitWidth: sourceText.implicitWidth
            implicitHeight: 34

            Text {
                id: sourceText
                anchors.centerIn: parent

                text: `${root.source?.audio?.muted ? "󰍭" : "󰍬"} ${root.source?.audio?.muted ? "Muted" : root.sourceVol + "%"}`
                color: Config.colors.mauve

                font {
                    family: "JetBrainsMono Nerd Font"
                    pixelSize: 16
                    bold: true
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: root.source.audio.muted = !root.source.audio.muted
                onWheel: e => root.source.audio.volume += (e.angleDelta.y > 0 ? 0.05 : -0.05)
            }
        }
    }

    PwObjectTracker {
        objects: [root.sink, root.source]
    }
}
