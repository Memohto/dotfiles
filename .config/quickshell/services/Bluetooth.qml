pragma Singleton

import Quickshell
import Quickshell.Bluetooth

Singleton {
    property var state: Bluetooth.defaultAdapter.state
}
