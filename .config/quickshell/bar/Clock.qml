import Quickshell
import QtQuick
import QtQuick.Layouts
import "../config.js" as Config

Rectangle {
    id: root
    implicitWidth: clock.implicitWidth + 24
    implicitHeight: 34

    radius: 10

    color: Config.colors.base

    Text {
        id: clock
        anchors.centerIn: parent
        text: Qt.formatDateTime(new Date(), " hh:mm:ss A    ddd, MMM dd yyyy")
        color: Config.colors.pink
        font {
            family: "JetBrainsMono Nerd Font"
            pixelSize: 16
            bold: true
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clock.text = Qt.formatDateTime(new Date(), " hh:mm:ss A    ddd, MMM dd yyyy")
        }
    }
}
