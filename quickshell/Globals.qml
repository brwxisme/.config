pragma Singleton

import Quickshell
import Quickshell.Io
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
    property var window_count: {
        "DP-2": 0,
        "HDMI-A-1": 0
    }
    //
    // property var window_count: ({})
    Item {
        id: namex
        Connections {
            target: Hyprland

            // function onFocusedWorkspaceChanged(lalal: HyprlandWorkspace) {
            function onRawEvent(event: HyprlandEvent): void {
                // function onFocusedMonitorChanged(lala: HyprlandMonitor): void {
                // console.log("NEW EVENT !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                // console.log(event.name);
                const e_name = event.name;
                const show = e_name.includes("workspace") || e_name.includes("mon");
                if (show) {
                    cmd_test.running = true;
                } else if (e_name.includes("openwindow")) {
                    // Globals.hideWorkspaces();
                    // Globals.showOnEmptyWorkspace();
                    update_window_count.running = true;
                } else if (e_name.includes("closewindow")) {
                    // Globals.windowKilled();
                    update_window_count.running = true;
                }
            }
        }
    }

    Process {
        id: cmd_test
        command: ["hyprctl", "activeworkspace", "-j"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                // root.time = this.text;
                var x = JSON.parse(text);
                // console.log(x.windows);
                Globals.monitors[x.monitor] = x.windows != 0;
                Globals.monitor_workspace_window_count = x.windows;
                root.window_count[x.monitor] = x.windows;

                // console.log(x.monitor, " is ", x.windows == 0, " windows count : ", x.windows);
                // console.log(x.monitor, " counts ", Globals.monitor_workspace_window_count);
                Globals.showWorkspaces();
            }
        }
    }
    Process {
        id: update_window_count
        command: ["hyprctl", "activeworkspace", "-j"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                var x = JSON.parse(text);
                // console.log(x.windows);
                Globals.monitors[x.monitor] = x.windows != 0;
                Globals.monitor_workspace_window_count = x.windows;
                root.window_count[x.monitor] = x.windows;
                console.log("DP ", root.window_count["DP-2"]);
                console.log("HDMI ", root.window_count["HDMI-A-1"]);
                Globals.showOnEmptyWorkspace();
            }
        }
    }
}
