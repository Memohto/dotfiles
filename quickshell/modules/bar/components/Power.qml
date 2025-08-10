import "root:/config"

import QtQuick
import Quickshell
import Quickshell.Widgets

Text {
    id: root

    required property PersistentProperties visibilities

    property real fill
    property int grade: -25

    text: "power_settings_new"

    renderType: Text.NativeRendering
    textFormat: Text.PlainText
    color: "#ffffff"

    font.bold: true
    font.family: Config.general.fontFamily.material
    font.pointSize: Config.general.fontSize.normal
    font.variableAxes: ({
            FILL: fill.toFixed(1),
            GRAD: grade,
            opsz: fontInfo.pixelSize,
            wght: fontInfo.weight
        })

    MouseArea {
        id: mouseArea

        property color color: "#ffffff"

        anchors.fill: undefined
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 1

        implicitWidth: parent.implicitHeight + Config.general.padding.small * 2
        implicitHeight: implicitWidth

        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onClicked: mouse => {
            root.visibilities.session = !root.visibilities.session;
        }

        ClippingRectangle {
            id: hoverLayer

            anchors.fill: parent

            color: Qt.alpha(mouseArea.color, mouseArea.pressed ? 0.2 : mouseArea.containsMouse ? 0.12 : 0)
            radius: Config.general.rounding.full

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
    }
}
