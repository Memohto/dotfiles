pragma ComponentBehavior: Bound

import "root:/config"
import QtQuick
import QtQuick.Effects
import Quickshell

Item {
    id: root

    required property Item bar

    anchors.fill: parent

    Rectangle {
        id: rect

        anchors.fill: parent
        color: "#171717"

        layer.enabled: true
        layer.effect: MultiEffect {
            maskSource: mask
            maskEnabled: true
            maskInverted: true
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1
        }
    }

    Item {
        id: mask

        anchors.fill: parent
        layer.enabled: true
        visible: false

        Rectangle {
            anchors.fill: parent
            anchors.margins: Config.border.thickness
            anchors.topMargin: root.bar.implicitHeight
            radius: Config.border.rounding
        }
    }
}
