pragma ComponentBehavior: Bound

import "root:/config"

import Quickshell
import Quickshell.Widgets
import QtQuick

Column {
    id: root

    required property PersistentProperties visibilities

    padding: Config.general.padding.large

    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left

    spacing: Config.general.spacing.large

    SessionButton {
        id: shutdown

        icon: "power_settings_new"
        command: ["systemctl", "poweroff"]
    }

    SessionButton {
        id: logout

        icon: "logout"
        command: ["loginctl", "terminate-user", ""]
    }

    SessionButton {
        id: hibernate

        icon: "bedtime"
        command: ["systemctl", "hibernate"]
    }

    SessionButton {
        id: reboot

        icon: "cached"
        command: ["systemctl", "reboot"]
    }

    component SessionButton: Rectangle {
        id: button

        required property string icon
        required property list<string> command

        implicitWidth: 80
        implicitHeight: 80

        radius: Config.general.rounding.large
        color: button.activeFocus ? "#484459" : "#201F25"

        MouseArea {
            id: area

            anchors.fill: parent

            enabled: true
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            onClicked: event => {
                Quickshell.execDetached(button.command);
            }

            ClippingRectangle {
                anchors.fill: parent

                color: Qt.alpha(text.color, area.pressed ? 0.1 : area.containsMouse ? 0.08 : 0)
                radius: button.radius

                Rectangle {
                    id: ripple

                    radius: Config.general.rounding.full
                    color: text.color
                    opacity: 0

                    transform: Translate {
                        x: -ripple.width / 2
                        y: -ripple.height / 2
                    }
                }
            }
        }

        Text {
            id: text

            anchors.centerIn: parent

            property real fill
            property int grade: -25

            text: button.icon

            renderType: Text.NativeRendering
            textFormat: Text.PlainText
            color: button.activeFocus ? "#E5DFF9" : "#E5E1E9"

            font.bold: true
            font.family: Config.general.fontFamily.material
            font.pointSize: Config.general.fontSize.largest
            font.weight: 500
            font.variableAxes: ({
                    FILL: fill.toFixed(1),
                    GRAD: grade,
                    opsz: fontInfo.pixelSize,
                    wght: fontInfo.weight
                })
        }
    }
}
