import "root:/config"
import "root:/services"
import "root:/components/controls"

import QtQuick

Column {
    id: root

    required property Brightness.Monitor monitor

    padding: Config.general.padding.large

    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left

    spacing: Config.general.spacing.normal

    MouseArea {
        implicitWidth: 30
        implicitHeight: 150

        onWheel: event => {
            if (event.angleDelta.y > 0)
                Audio.incrementVolume();
            else if (event.angleDelta.y < 0)
                Audio.decrementVolume();
        }

        FilledSlider {
            id: slider

            anchors.fill: parent

            icon: {
                if (Audio.muted)
                    return "no_sound";
                if (slider.value >= 0.5)
                    return "volume_up";
                if (slider.value > 0)
                    return "volume_down";
                return "volume_mute";
            }
            value: Audio.volume
            onMoved: Audio.setVolume(value)
        }
    }

    MouseArea {
        implicitWidth: 30
        implicitHeight: 150

        onWheel: event => {
            const monitor = root.monitor;
            if (!monitor)
                return;
            if (event.angleDelta.y > 0)
                monitor.setBrightness(monitor.brightness + 0.1);
            else if (event.angleDelta.y < 0)
                monitor.setBrightness(monitor.brightness - 0.1);
        }

        FilledSlider {
            anchors.fill: parent

            icon: `brightness_${(Math.round(value * 6) + 1)}`
            value: root.monitor?.brightness ?? 0
            onMoved: root.monitor?.setBrightness(value)
        }
    }
}
