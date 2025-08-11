pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    property var state: UPower.displayDevice.state
    property bool isCharging: state == UPowerDeviceState.Charging
    property bool isPluggedIn: isCharging || state == UPowerDeviceState.PendingCharge
    property real percentage: UPower.displayDevice.percentage

    property bool isAlmostFull: percentage <= 0.90
    property bool isVeryGood: percentage <= 0.80
    property bool isGood: percentage <= 0.60
    property bool isHalf: percentage <= 0.50
    property bool isLow: percentage <= 0.30
    property bool isCritical: percentage <= 0.15
    property bool isEmpty: percentage <= 0.02

    property string icon: {
        var icon = "";

        if (isEmpty) {
            icon = isPluggedIn ? "battery_charging_full" : "battery_0_bar";
        } else if (isCritical) {
            icon = isPluggedIn ? "battery_charging_20" : "battery_1_bar";
        } else if (isLow) {
            icon = isPluggedIn ? "battery_charging_30" : "battery_2_bar";
        } else if (isHalf) {
            icon = isPluggedIn ? "battery_charging_50" : "battery_3_bar";
        } else if (isGood) {
            icon = isPluggedIn ? "battery_charging_60" : "battery_4_bar";
        } else if (isVeryGood) {
            icon = isPluggedIn ? "battery_charging_80" : "battery_5_bar";
        } else if (isAlmostFull) {
            icon = isPluggedIn ? "battery_charging_90" : "battery_6_bar";
        } else {
            icon = "battery_full";
        }

        return icon;
    }
}
