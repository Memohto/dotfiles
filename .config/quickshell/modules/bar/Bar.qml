pragma ComponentBehavior: Bound

import "root:/config"
import "components"
import "components/workspaces"

import QtQuick
import Quickshell

Item {
    id: root

    required property PersistentProperties visibilities

    anchors.top: parent.top
    anchors.right: parent.right
    anchors.left: parent.left

    implicitHeight: components.implicitHeight + Config.border.thickness * 2

    function checkPopout(x: real, y: real): void {
        if (x >= utilsContainer.x && x <= utilsContainer.x + utilsContainer.width && y <= height) {
            var relativeX = x - utilsContainer.x;
            var itemWidth = utilsContainer.width / 3;
            var child = null;

            if (relativeX <= itemWidth) {
                child = utils.children[0];
            } else if (relativeX <= itemWidth * 2) {
                child = utils.children[1];
            } else {
                child = utils.children[2];
            }

            for (var i = 0; i < utils.children.length; i++) {
                if (child == utils.children[i]) {
                    utils.children[i].showPopup();
                } else {
                    utils.children[i].hidePopup();
                }
            }
        } else {
            for (var i = 0; i < utils.children.length; i++) {
                utils.children[i].hidePopup();
            }
        }
    }

    function closePopouts(): void {
        for (var i = 0; i < utils.children.length; i++) {
            utils.children[i].hidePopup();
        }
    }

    function checkUtils(x: real, y: real): void {
        if (x >= utilsContainer.x && x <= utilsContainer.x + utilsContainer.width && y <= height) {
            var relativeX = x - utilsContainer.x;
            var itemWidth = utilsContainer.width / 3;
            var child = null;

            if (relativeX <= itemWidth) {
                child = utils.children[0];
            } else if (relativeX <= itemWidth * 2) {
                child = utils.children[1];
            } else {
                child = utils.children[2];
            }

            if (child) {
                child.activate();
            }
        }
    }

    Item {
        id: components

        anchors.right: parent.right
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        implicitHeight: 25

        OsIcon {
            id: osIcon

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Config.general.spacing.largest
        }

        Rectangle {
            id: workspacesContainer

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: osIcon.right
            anchors.leftMargin: Config.general.spacing.largest

            radius: Config.general.rounding.full
            color: "#303030"

            implicitWidth: workspaces.implicitWidth + Config.general.padding.smaller * 2
            implicitHeight: workspaces.implicitHeight + Config.general.padding.smaller * 2

            Workspaces {
                id: workspaces

                // Absolute possitioning the text in the container, otherwise it looks off
                x: (parent.width - width) / 2 + 9
                y: (parent.height - height) / 2
            }
        }

        Clock {
            id: clock

            anchors.centerIn: parent
        }

        Rectangle {
            id: utilsContainer

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: power.left
            anchors.rightMargin: Config.general.spacing.largest

            radius: Config.general.rounding.full
            color: "#303030"

            implicitWidth: utils.implicitWidth + Config.general.padding.smaller * 3
            implicitHeight: utils.implicitHeight + Config.general.padding.smaller * 2

            Row {
                id: utils

                spacing: 13
                anchors.verticalCenter: parent.verticalCenter

                // Absolute possitioning the text in the container, otherwise it looks off
                x: (parent.width - width) / 2

                Battery {
                    id: battery
                }

                Bluetooth {
                    id: bluetooth
                }

                Wifi {
                    id: wifi
                }
            }
        }

        Power {
            id: power

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: Config.general.padding.largest

            visibilities: root.visibilities
        }
    }
}
