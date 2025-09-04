//@ pragma UseQApplication
//@ pragma IconTheme Flatery-Indigo-Dark
import Quickshell
import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import Quickshell.Hyprland
import "OSDs" as OSD
import Quickshell.Wayland
import "Workspace" as WS
import "Tray" as Tray

ShellRoot {
    // Bar {}
    Background {}
    OSD.Osds {
        id: osds
    }
    // Corners {}
    // WSTest {}
    // PanelWindow {
    //     color: "transparent"
    //     height: 400
    //     width: 400
    //     Corner {
    //         my_height: 64
    //         my_width: 64
    //     }
    // }
    // BarCorner {
    //     id: bar_corner
    // }
    // OverlayWorkspace {}
    // OverlayWorkspaceNoCorner {}
    // WorkspaceBar {}
    BarManager {}
    // WorkspaceIndicator {}
    // BottomBar {}

    // Tray.SystemTrays {}
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
                    Globals.showOnEmptyWorkspace();
                } else if (e_name.includes("closewindow")) {
                    // Globals.windowKilled();
                    Globals.showOnEmptyWorkspace();
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

                // console.log(x.monitor, " is ", x.windows == 0, " windows count : ", x.windows);
                console.log(x.monitor, " counts ", Globals.monitor_workspace_window_count);
                Globals.showWorkspaces();
            }
        }
    }
}
