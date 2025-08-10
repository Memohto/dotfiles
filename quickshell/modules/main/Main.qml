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
            WlrLayershell.layer: WlrLayer.Background
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

            anchors.top: true
            anchors.bottom: true
            anchors.left: true
            anchors.right: true

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
            }

            PersistentProperties {
                id: visibilities

                property bool session

                Component.onCompleted: Visibilities.load(scope.modelData, this)
            }

            Panels {
                id: panels

                visibilities: visibilities
                bar: bar
            }

            Bar {
                id: bar

                visibilities: visibilities
            }
        }
    }
}
