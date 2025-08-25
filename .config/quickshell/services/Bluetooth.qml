pragma Singleton

import Quickshell
import Quickshell.Bluetooth

Singleton {
    property string state: BluetoothAdapterState.toString(Bluetooth.defaultAdapter?.state)
    property bool isOn: Bluetooth.defaultAdapter?.enabled ?? false
    property var connectedDevice

    property bool isConnected: {
        var isConnected = false;

        var devices = Bluetooth.defaultAdapter?.devices.values ?? 0
        for (var i = 0; i < devices.length; i++) {
            if (devices[i].connected) {
                isConnected = true;
                connectedDevice = devices[i];
                break;
            }
        }

        if (!isConnected)
            connectedDevice = null;

        return isConnected;
    }

    property string connectedDeviceName: {
        var name = "";
        if (connectedDevice) {
            name = connectedDevice.name;
        }
        return name;
    }

    property real connectedDeviceBattery: {
        var battery = 0;
        if (connectedDevice) {
            battery = connectedDevice.battery * 100;
        }
        return battery;
    }

    property string icon: {
        var icon = "";

        if (!isOn) {
            icon = "bluetooth_disabled";
        } else {
            if (isConnected) {
                icon = "bluetooth_connected";
            } else {
                icon = "bluetooth";
            }
        }

        return icon;
    }
}
