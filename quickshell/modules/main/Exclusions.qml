pragma ComponentBehavior: Bound

import "root:/config"
import Quickshell
import Quickshell.Wayland
import QtQuick

Scope {
    id: root

    required property ShellScreen screen
    required property Item bar

    ExclusionZone {
        anchors.left: true
    }

    ExclusionZone {
        anchors.top: true
        exclusiveZone: root.bar.implicitHeight
    }

    ExclusionZone {
        anchors.right: true
    }

    ExclusionZone {
        anchors.bottom: true
    }

    component ExclusionZone: PanelWindow {
        screen: root.screen
        color: "transparent"
        WlrLayershell.namespace: "quickshell-border-exclusion"
        exclusiveZone: Config.border.thickness
        mask: Region {}
    }
}
