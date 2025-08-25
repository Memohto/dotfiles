import "root:/services"
import "root:/config"
import "root:/modules/osd" as Osd
import "root:/modules/session" as Session

import QtQuick
import QtQuick.Shapes

Shape {
    id: root

    required property Panels panels
    required property Item bar

    anchors.fill: parent
    anchors.margins: Config.border.thickness
    anchors.topMargin: bar.implicitHeight
    preferredRendererType: Shape.CurveRenderer

    Osd.Background {
        wrapper: root.panels.osd

        startX: root.width - root.panels.session.width
        startY: (root.height - wrapper.height) / 2 - rounding
    }

    Session.Background {
        wrapper: root.panels.session

        startX: root.width
        startY: (root.height - wrapper.height) / 2 - rounding
    }
}
