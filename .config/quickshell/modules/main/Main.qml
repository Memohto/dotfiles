pragma ComponentBehavior: Bound

import "root:/services"
import "root:/config"
import "root:/modules/bar"

import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects

Variants {
    model: Quickshell.screens

    Scope {
        id: scope

        required property ShellScreen modelData

        Exclusions {
            screen: scope.modelData
            bar: bar
        }

        PanelWindow {
            id: win

            screen: scope.modelData
            color: "transparent"

            WlrLayershell.namespace: "quickshell-main"
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.keyboardFocus: visibilities.session ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

            mask: Region {
                x: Config.border.thickness
                y: bar.implicitHeight
                width: win.width - Config.border.thickness * 2
                height: win.height - bar.implicitHeight - Config.border.thickness
                intersection: Intersection.Xor

                regions: regions.instances
            }

            anchors.top: true
            anchors.bottom: true
            anchors.left: true
            anchors.right: true

            Variants {
                id: regions

                model: panels.children

                Region {
                    required property Item modelData

                    x: modelData.x + Config.border.thickness
                    y: modelData.y + bar.implicitHeight
                    width: modelData.width
                    height: modelData.height
                    intersection: Intersection.Subtract
                }
            }

            Rectangle {
                anchors.fill: parent
                opacity: visibilities.session ? 0.5 : 0
                color: "#000000"

                Behavior on opacity {
                    NumberAnimation {
                        duration: Config.general.anim.durations.normal
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: Config.general.anim.curves.standard
                    }
                }
            }

            Item {
                anchors.fill: parent
                layer.enabled: true
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    blurMax: 15
                    shadowColor: Qt.alpha("#000000", 0.7)
                }

                Border {
                    bar: bar
                }

                Backgrounds {
                    panels: panels
                    bar: bar
                }
            }

            PersistentProperties {
                id: visibilities

                property bool osd
                property bool session

                Component.onCompleted: Visibilities.load(scope.modelData, this)
            }

            Interactions {
                screen: scope.modelData
                visibilities: visibilities
                panels: panels
                bar: bar

                Panels {
                    id: panels

                    screen: scope.modelData
                    visibilities: visibilities
                    bar: bar
                }
            }

            Bar {
                id: bar

                visibilities: visibilities
            }
        }
    }
}
