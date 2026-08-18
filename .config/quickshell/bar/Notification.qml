import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "../config.js" as Config

Rectangle {
    id: root

    property string alt: "none"
    property int count: 0

    implicitWidth: row.implicitWidth + 24
    implicitHeight: 34

    radius: 10

    color: Config.colors.base

    Process {
        command: ["swaync-client", "-swb"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                const obj = JSON.parse(data);

                root.alt = obj.alt;
                root.count = Number(obj.text);
            }
        }
    }

    Item {
        id: row
        implicitWidth: 20
        implicitHeight: 24
        anchors.centerIn: parent

        Text {
            text: root.alt.includes("dnd") ? "󰪑" : "󰂜"
            anchors.centerIn: parent
            color: Config.colors.red
            font {
                family: "JetBrainsMono Nerd Font"
                pixelSize: 16
                bold: true
            }
        }

        Text {
            visible: root.alt.includes("notification")
            text: ""
            color: "#ff0000"
            font.pixelSize: 9
            anchors {
                top: row.top
                right: row.right
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: e => Quickshell.execDetached(e.button === Qt.LeftButton ? ["swaync-client", "-t", "-sw"] : ["swaync-client", "-d"])
    }
}
