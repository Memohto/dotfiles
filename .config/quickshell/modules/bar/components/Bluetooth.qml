import "root:/config"
import "root:/services"

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Bluetooth

Text {
    id: root

    property real fill
    property int grade: -25

    text: "bluetooth"

    renderType: Text.NativeRendering
    textFormat: Text.PlainText
    color: "#ffffff"

    font.bold: true
    font.family: Config.general.fontFamily.material
    font.pointSize: Config.general.fontSize.large
    font.variableAxes: ({
            FILL: fill.toFixed(1),
            GRAD: grade,
            opsz: fontInfo.pixelSize,
            wght: fontInfo.weight
        })

    Component.onCompleted: {
        console.log(Bluetooth.defaultAdapter.state);
    }

    ClippingRectangle {
        id: hoverLayer

        anchors.fill: undefined
        anchors.centerIn: parent

        implicitWidth: parent.implicitHeight + Config.general.padding.large
        implicitHeight: parent.implicitHeight * 1.5

        color: Qt.alpha(mouseArea.color, mouseArea.containsMouse ? 1 : 0)
        topRightRadius: Config.general.rounding.full
        topLeftRadius: Config.general.rounding.full

        z: -1

        Rectangle {
            id: ripple

            radius: Config.general.rounding.full
            color: mouseArea.color
            opacity: 0

            transform: Translate {
                x: -ripple.width / 2
                y: -ripple.height / 2
            }
        }
    }

    MouseArea {
        id: mouseArea

        property color color: "#171717"

        anchors.fill: undefined
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 1

        implicitWidth: parent.implicitHeight + Config.general.padding.smaller
        implicitHeight: parent.implicitHeight * 1.5

        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        Process {
            id: process

            running: false
            command: ["kitty", "--class", "QuickshellFloat", "bluetui"]
        }

        onClicked: mouse => {
            process.startDetached();
        }
    }
}
