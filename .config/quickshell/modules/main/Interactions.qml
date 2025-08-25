import "root:/config"

import Quickshell
import QtQuick

MouseArea {
    id: root

    required property ShellScreen screen
    required property PersistentProperties visibilities
    required property Panels panels
    required property Item bar

    anchors.fill: parent
    hoverEnabled: true

    function withinPanelHeight(panel: Item, x: real, y: real): bool {
        const panelY = Config.border.thickness + panel.y;
        return y >= panelY - Config.border.rounding && y <= panelY + panel.height + Config.border.rounding;
    }

    function inRightPanel(panel: Item, x: real, y: real): bool {
        return x > Config.border.thickness + panel.x && withinPanelHeight(panel, x, y);
    }

    onContainsMouseChanged: {
        if (!containsMouse) {
            bar.closePopouts();

            visibilities.osd = false;
        }
    }

    onPositionChanged: event => {
        const x = event.x;
        const y = event.y;

        bar.checkPopout(x, y);

        const showOsd = inRightPanel(panels.osd, x, y) && !visibilities.session
        visibilities.osd = showOsd;
    }

    onClicked: event => {
        const x = event.x;
        const y = event.y;

        bar.checkUtils(x, y);
    }
}
