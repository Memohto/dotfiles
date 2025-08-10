import "root:/config"
import "root:/services"

import QtQuick

Column {
    id: root

    property color color: "#ffffff"

    spacing: Config.general.spacing.smaller

    Text {
        id: text

        text: Time.format("  hh:mm |   dddd MM/dd")
        font.pointSize: Config.general.fontSize.small
        font.family: Config.general.fontFamily.mono
        color: root.color
    }
}
