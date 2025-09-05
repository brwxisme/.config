pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

// your singletons should always have Singleton as the type
Singleton {
    id: root

    signal showWorkspaces
    signal hideWorkspaces
    signal windowKilled
    signal showOnEmptyWorkspace
    signal changeBackground

    property var monitor_workspace_window_count
    property var monitors: {
        "DP-2": false
        // "HDMI-A-1": false
    }
}
