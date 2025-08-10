pragma ComponentBehavior: Bound

import "root:/config"

import QtQuick
import QtQuick.Layouts

Item {
    id: root

    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    RowLayout {
        id: layout

        spacing: 0
        layer.enabled: true
        layer.smooth: true

        Repeater {
            model: 5

            Workspace {}
        }
    }
}
