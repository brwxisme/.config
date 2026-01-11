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
    signal activeWindowChanged
    signal windowKilled
    signal showOnEmptyWorkspace
    signal changeBackground
    signal showBar(val: string)
    signal modPressed(val: string)
    signal modReleased(val: string)
    signal tiledWindowCountChanged

    property var monitor_workspace_window_count
    property var monitors: {
        "DP-2": false
        // "HDMI-A-1": false
    }
    property var window_count: {
        "DP-2": 0,
        "HDMI-A-1": 0
    }
    property var tiled_on_workspace: {
        "0": 0
    }
    property bool showingBar: false

    property string time
    property string date
    property bool showCrosshair: false

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
                //
                const e_name = event.name;

                const show = e_name.includes("workspace") || e_name.includes("mon");
                if (show) {
                    cmd_test.running = true;
                    update_tiled_count.running = true;
                } else if (e_name.includes("openwindow")) {
                    // Globals.hideWorkspaces();
                    // Globals.showOnEmptyWorkspace();
                    update_window_count.running = true;
                } else if (e_name.includes("closewindow")) {
                    // Globals.windowKilled();
                    update_window_count.running = true;
                }
                if (e_name.includes("activewindowv2")) {
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
                //console.log(x);
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
                Globals.activeWindowChanged();
            }
        }
    }
    Process {
        id: update_tiled_count
        command: ["hyprctl", "clients", "-j"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                var clients = JSON.parse(text);

                root.tiled_on_workspace = {};

                for (const win of clients) {
                    // skip floating windows
                    if (win.floating) {
                        continue;
                    }

                    var wsId = win.workspace.id;

                    // init counter if missing
                    if (root.tiled_on_workspace[wsId] === undefined) {
                        root.tiled_on_workspace[wsId] = 0;
                    }

                    root.tiled_on_workspace[wsId] += 1;
                }

                Globals.tiledWindowCountChanged();
                // console.log("tiled_on_workspace:", JSON.stringify(root.tiled_on_workspace));
            }
        }
    }
    Process {
        id: timeProc
        // command: ["date", "+%A %H:%M"]
        command: ["date", "+%H:%M"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: time = this.text.replace(/(\r\n|\n|\r)/gm, "")
        }
    }

    Process {
        id: dateProc
        // command: ["date", "+%A %H:%M"]
        command: ["date", "+%A, %d %B"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: date = this.text.replace(/(\r\n|\n|\r)/gm, "")
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            dateProc.running = true;
            timeProc.running = true;
        }
    }
    GlobalShortcut {
        appid: "quickshell"
        name: "open-bar"
        onReleased: {
            root.toggleBar();
        }
    }
    function toggleBar(): void {
        root.showingBar = !root.showingBar;
        root.showBar("HDMI-A-1");
        if (root.showingBar) {
            auto_hide.start();
        }
    }
    function shouldShow(mon_name: string): bool {
        if (root.showingBar) {
            return true;
        }
        return window_count[mon_name] == 0;
    }
    Timer {
        id: auto_hide
        interval: 10000
        running: false
        onTriggered: {
            if (root.showingBar) {
                root.toggleBar();
            }
        }
    }

    function keypressed_from_socket(message: string) {
        var x = JSON.parse(message);
        // console.log(x.key);
        // console.log(x.pressed);
        if (x.pressed == "true") {
            root.modPressed(x.key);
        } else {
            root.modReleased(x.key);
        }
    }
}
