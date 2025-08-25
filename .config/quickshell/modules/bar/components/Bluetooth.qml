import "root:/config"
import "root:/services"

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

Text {
    id: root

    property real fill
    property int grade: -25

    property bool isHovered: false

    text: Bluetooth.icon

    renderType: Text.NativeRendering
    textFormat: Text.PlainText
    color: Bluetooth.isConnected ? "#798FFC" : "#ffffff"

    font.bold: true
    font.family: Config.general.fontFamily.material
    font.pointSize: Config.general.fontSize.large
    font.variableAxes: ({
            FILL: fill.toFixed(1),
            GRAD: grade,
            opsz: fontInfo.pixelSize,
            wght: fontInfo.weight
        })

    function showPopup() {
        isHovered = true;
        // popupLoader.item.visible = true;
    }

    function hidePopup() {
        isHovered = false;
        // popupLoader.item.visible = false;
    }

    function activate() {
        process.startDetached();
    }

    Process {
        id: process

        running: false
        command: ["kitty", "--class", "QuickshellFloat", "bluetui"]
    }

    ClippingRectangle {
        id: hoverLayer

        anchors.fill: undefined
        anchors.centerIn: parent

        implicitWidth: parent.implicitHeight + Config.general.padding.large
        implicitHeight: parent.implicitHeight * 1.5

        color: Qt.alpha("#171717", root.isHovered ? 1 : 0)
        topRightRadius: Config.general.rounding.full
        topLeftRadius: Config.general.rounding.full

        z: -1

        Rectangle {
            id: ripple

            radius: Config.general.rounding.full
            opacity: 0

            transform: Translate {
                x: -ripple.width / 2
                y: -ripple.height / 2
            }
        }
    }

    // PanelWindow {
    //     id: popupWindow
    //
    //     implicitWidth: 300
    //     implicitHeight: 150
    //
    //     color: "transparent"
    //
    //     anchors {
    //         top: true
    //         right: true
    //     }
    //
    //     LazyLoader {
    //         id: popupLoader
    //
    //         loading: true
    //
    //         PopupWindow {
    //             id: popup
    //
    //             anchor.window: popupWindow
    //             implicitWidth: popupWindow.implicitWidth
    //             implicitHeight: popupWindow.implicitHeight
    //
    //             color: "transparent"
    //
    //             Rectangle {
    //                 id: popupContent
    //
    //                 anchors.fill: parent
    //                 bottomLeftRadius: Config.general.rounding.small
    //
    //                 color: "#171717"
    //
    //                 Column {
    //                     anchors.verticalCenter: parent.verticalCenter
    //                     anchors.centerIn: parent
    //
    //                     Text {
    //                         color: "#ffffff"
    //                         font.pointSize: Config.general.fontSize.small
    //                         font.family: Config.general.fontFamily.mono
    //                         font.bold: true
    //
    //                         text: "Bluetooth info\n\n"
    //                     }
    //
    //                     Text {
    //                         color: "#ffffff"
    //                         font.pointSize: Config.general.fontSize.smaller
    //                         font.family: Config.general.fontFamily.mono
    //
    //                         text: "Status: " + Bluetooth.state
    //                     }
    //
    //                     Text {
    //                         color: "#ffffff"
    //                         font.pointSize: Config.general.fontSize.smaller
    //                         font.family: Config.general.fontFamily.mono
    //
    //                         text: "Connected device:\n  " + (Bluetooth.connectedDevice ? Bluetooth.connectedDeviceName + " (󰁾 " + Bluetooth.connectedDeviceBattery + "%)" : "No device")
    //                     }
    //                 }
    //             }
    //         }
    //     }
    // }
}
