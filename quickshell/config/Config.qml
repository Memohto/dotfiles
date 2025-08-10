pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias general: adapter.general
    property alias border: adapter.border

    JsonAdapter {
        id: adapter

        property JsonObject general: GeneralConfig {}
        property JsonObject border: BorderConfig {}
    }
}
