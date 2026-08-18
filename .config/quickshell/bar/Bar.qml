import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel
            WlrLayershell.namespace: "quickshell-bar"
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 44
            // color: "#ff0000"
            color: "transparent"

            RowLayout {
                anchors {
                    fill: parent
                    topMargin: 10
                    leftMargin: 20
                    rightMargin: 20
                }
                spacing: 0

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    RowLayout {
                        anchors.left: parent.left
                        spacing: 10

                        Launcher {}

                        Hyprland {
                            screen: panel.modelData
                        }

                        Monitor {}
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Clock {
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    RowLayout {
                        anchors.right: parent.right
                        spacing: 10
                        Tray {
                            panelWindow: panel
                        }
                        Audio {}
                        Battery {}
                        Notification {}
                    }
                }
            }
        }
    }
}
