import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "../config.js" as Config

Rectangle {
    id: root
    implicitWidth: clock.implicitWidth + 24
    implicitHeight: 34

    radius: 10

    color: Config.colors.base

    property string text

    Process {
        id: monitor
        command: ["sh", "-c", "~/.config/waybar/scripts/hwmonitor.sh"]
        stdout: SplitParser {
            onRead: data => root.text = data
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 4000
        running: true
        repeat: true
        onTriggered: monitor.running = true
    }

    Text {
        id: clock
        anchors.centerIn: parent
        text: root.text
        color: Config.colors.lavender
        font {
            family: "JetBrainsMono Nerd Font"
            pixelSize: 16
            bold: true
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
    }
}
