import "root:/config"

import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    required property int index

    property real preferredWidth: childrenRect.width + Config.general.padding.small
    property real preferredHeight: childrenRect.height 

    Layout.preferredWidth: preferredWidth
    Layout.preferredHeight: preferredHeight

    Text {
        id: indicator

        text: Hyprland.focusedWorkspace?.id - 1 == index ? "" : ""
        color: Hyprland.focusedWorkspace?.id - 1 == index ? "#ffffff" : "#505050"
        font.pointSize: Hyprland.focusedWorkspace?.id - 1 == index ? Config.general.fontSize.large : Config.general.fontSize.smaller

        width: 25
    }
}
