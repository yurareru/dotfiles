import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import "../config.js" as Config

Rectangle {
    id: root

    property var battery: UPower.displayDevice
    property bool charging: battery.state === UPowerDeviceState.Charging
    readonly property int level: Math.round(battery.percentage * 100)

    visible: battery.type

    readonly property string icon: {
        if (charging)
            return "󰂄";
        if (level >= 100)
            return "󰁹";
        if (level < 10)
            return "󰂃";

        return String.fromCodePoint(0xf007a + Math.floor(level / 10) - 1);
    }

    implicitWidth: text.implicitWidth + 24
    implicitHeight: 34

    radius: 10
    color: Config.colors.base
    Text {
        id: text
        anchors.centerIn: parent

        text: `${root.icon} ${root.level}%`
        color: root.charging ? Config.colors.green : root.level <= 15 ? Config.colors.red : root.level <= 30 ? Config.colors.yellow : Config.colors.green

        font {
            family: "JetBrainsMono Nerd Font"
            pixelSize: 16
            bold: true
        }
    }
}
