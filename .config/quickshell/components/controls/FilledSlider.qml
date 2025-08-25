import "root:/config"

import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Slider {
    id: root

    required property string icon
    property real oldValue

    orientation: Qt.Vertical

    background: Rectangle {
        color: "#201F25"
        radius: Config.general.rounding.full

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right

            y: root.handle.y
            implicitHeight: parent.height - y

            color: "#C9C3DC"
            radius: parent.radius
        }
    }

    handle: Item {
        id: handle

        property bool moving

        y: root.visualPosition * (root.availableHeight - height)
        implicitWidth: root.width
        implicitHeight: root.width

        RectangularShadow {
            anchors.fill: parent
            radius: rect.radius

            property int level: handleInteraction.containsMouse ? 2 : 1
            property real dp: [0, 1, 3, 6, 8, 12][level]

            color: Qt.alpha("#000000", 0.7)
            blur: (dp * 5) ** 0.7
            spread: -dp * 0.3 + (dp * 0.1) ** 2
            offset.y: dp / 2

            Behavior on dp {
                NumberAnimation {
                    duration: Config.general.anim.durations.normal
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Config.general.anim.curves.standard
                }
            }
        }

        Rectangle {
            id: rect

            anchors.fill: parent

            color: "#E5E1E9"
            radius: Config.general.rounding.full

            MouseArea {
                id: handleInteraction

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.NoButton
            }

            Text {
                id: icon

                property bool moving: handle.moving
                property real fill
                property int grade: -25

                anchors.centerIn: parent

                text: root.icon
                color: "#312F36"

                renderType: Text.NativeRendering
                textFormat: Text.PlainText

                font.bold: true
                font.family: Config.general.fontFamily.material
                font.pointSize: Config.general.fontSize.large
                font.variableAxes: ({
                        FILL: fill.toFixed(1),
                        GRAD: grade,
                        opsz: fontInfo.pixelSize,
                        wght: fontInfo.weight
                    })

                function update(): void {
                    text = moving ? Qt.binding(() => Math.round(root.value * 100)) : Qt.binding(() => root.icon);
                    font.pointSize = moving ? Config.general.fontSize.small : Config.general.fontSize.larger;
                    font.family = moving ? Config.general.fontFamily.sans : Config.general.fontFamily.material;
                }

                Behavior on moving {
                    SequentialAnimation {
                        NumberAnimation {
                            target: icon
                            property: "scale"
                            from: 1
                            to: 0
                            duration: Config.general.anim.durations.normal / 2
                            easing.type: Easing.BezierSpline
                            easing.bezierCurve: Config.general.anim.curves.standardAccel
                        }
                        ScriptAction {
                            script: icon.update()
                        }
                        NumberAnimation {
                            target: icon
                            property: "scale"
                            from: 0
                            to: 1
                            duration: Config.general.anim.durations.normal / 2
                            easing.type: Easing.BezierSpline
                            easing.bezierCurve: Config.general.anim.curves.standardDecel
                        }
                    }
                }
            }
        }
    }

    onPressedChanged: handle.moving = pressed

    onValueChanged: {
        if (Math.abs(value - oldValue) < 0.01)
            return;
        oldValue = value;
        handle.moving = true;
        stateChangeDelay.restart();
    }

    Timer {
        id: stateChangeDelay

        interval: 500
        onTriggered: {
            if (!root.pressed)
                handle.moving = false;
        }
    }

    Behavior on value {
        NumberAnimation {
            duration: Config.general.anim.durations.large
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Config.general.anim.curves.standard
        }
    }
}
