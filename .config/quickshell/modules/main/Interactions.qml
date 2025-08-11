import Quickshell
import QtQuick

MouseArea {
    id: root

    required property Item bar

    anchors.fill: parent
    hoverEnabled: true

    onPositionChanged: event => {
        const x = event.x;
        const y = event.y;

        bar.checkPopout(x, y);
    }

    onExited: {
        bar.closePopouts();
    }

    onClicked: event => {
        const x = event.x;
        const y = event.y;

        bar.checkUtils(x, y);
    }
}
