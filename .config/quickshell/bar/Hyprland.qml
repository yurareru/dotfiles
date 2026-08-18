import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../config.js" as Config

Rectangle {
    id: root
    required property var screen
    implicitWidth: workspaces.implicitWidth
    implicitHeight: 34

    radius: 10
    color: Config.colors.base

    Row {
        id: workspaces

        anchors.centerIn: parent

        Repeater {
            model: Hyprland.workspaces.values.filter(ws => ws.monitor?.name === root.screen.name)

            Rectangle {
                id: wsContainer
                required property var modelData
                property bool urgent: Hyprland.toplevels.values.some(window => window.workspace?.id === wsContainer.modelData.id && window.urgent)

                implicitWidth: wsText.implicitWidth + 24
                implicitHeight: 34
                radius: 10

                color: hover.hovered ? Qt.alpha(Config.colors.pink, 0.1) : "transparent"

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }

                Text {
                    id: wsText

                    text: wsContainer.modelData.id
                    anchors.centerIn: parent

                    color: wsContainer.modelData.active ? Config.colors.pink : wsContainer.urgent ? Config.colors.green : Qt.alpha(Config.colors.pink, 0.3)

                    font {
                        family: "JetBrainsMono Nerd Font"
                        pixelSize: 16
                        bold: true
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: Hyprland.dispatch(`hl.dsp.focus { workspace = ${wsContainer.modelData.id} }`)
                    onWheel: e => Hyprland.dispatch(`hl.dsp.focus { workspace = "${e.angleDelta.y > 0 ? "m+1" : "m-1"}" }`)
                }

                HoverHandler {
                    id: hover
                }
            }
        }
    }
}
