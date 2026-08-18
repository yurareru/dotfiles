import Quickshell
import QtQuick
import QtQuick.Layouts
import "../config.js" as Config

Rectangle {
    implicitWidth: archLogo.implicitWidth + 24
    implicitHeight: 34

    radius: 10

    color: Config.colors.base

    Text {
        id: archLogo
        anchors.centerIn: parent
        text: "󰣇"
        color: Config.colors.pink
        font {
            family: "JetBrainsMono Nerd Font"
            pixelSize: 16
            bold: true
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: Quickshell.execDetached(["rofi", "-show", "drun"])
    }
}
