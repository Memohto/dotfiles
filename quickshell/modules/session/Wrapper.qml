import "root:/config"

import Quickshell
import QtQuick

Item {
    id: root

    required property PersistentProperties visibilities

    visible: width > 0
    implicitWidth: 0
    implicitHeight: content.implicitHeight

    states: State {
        name: "visible"
        when: root.visibilities.session

        PropertyChanges {
            root.implicitWidth: content.implicitWidth
        }
    }

    transitions: [
        Transition {
            from: ""
            to: "visible"

            NumberAnimation {
                target: root
                property: "implicitWidth"
                duration: Config.general.anim.durations.normal
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Config.general.anim.curves.expressiveDefaultSpatial
            }
        },
        Transition {
            from: "visible"
            to: ""

            NumberAnimation {
                target: root
                property: "implicitWidth"
                duration: Config.general.anim.durations.normal
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Config.general.anim.curves.emphasized
            }
        }
    ]

    Content {
        id: content

        visibilities: root.visibilities
    }
}
