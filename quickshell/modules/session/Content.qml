pragma ComponentBehavior: Bound

import "root:/config"

import Quickshell
import QtQuick

Column {
    id: root

    required property PersistentProperties visibilities

    padding: Config.general.padding.large

    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left

    spacing: Config.general.spacing.large

    SessionButton {
        id: logout

        icon: "logout"
        command: ["loginctl", "terminate-user", ""]

        // KeyNavigation.down: shutdown

        // Connections {
        //     target: root.visibilities
        //
        //     function onSessionChanged(): void {
        //         if (root.visibilities.session)
        //             logout.focus = true;
        //     }
        //
        //     function onLauncherChanged(): void {
        //         if (root.visibilities.session && !root.visibilities.launcher)
        //             logout.focus = true;
        //     }
        // }
    }

    component SessionButton: Rectangle {
        id: button

        required property string icon
        required property list<string> command

        implicitWidth: 80
        implicitHeight: 80

        radius: Config.general.rounding.large
        color: "#ffffff"

        Keys.onEnterPressed: Quickshell.execDetached(button.command)
        Keys.onReturnPressed: Quickshell.execDetached(button.command)
        Keys.onEscapePressed: root.visibilities.session = false

        Text {
            anchors.centerIn: parent

            property real fill
            property int grade: -25

            text: button.icon

            renderType: Text.NativeRendering
            textFormat: Text.PlainText
            color: "#ffffff"

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
