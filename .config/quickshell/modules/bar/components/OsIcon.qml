pragma ComponentBehavior: Bound

import "root:/config"

import QtQuick

Text {
    text: ""
    font.pointSize: Config.general.fontSize.large
    font.family: Config.general.fontFamily.mono
    color: "#FFFFFF"
}
