//@ pragma UseQApplication
//@ pragma IconTheme Flatery-Indigo-Dark
import Quickshell
import Quickshell.Io
import QtQuick
import "OSDs" as OSD
import "VerticalWorkspace"
import "ModeTwo"
import "ModeOne"
import "Sockets"
import "OffsetCrosshair"
import "WindowIndicator"

// import "Background"

ShellRoot {
    // Background {}
    // ClockBackground {}
    // OSD.Osds {
    //     id: osds
    // }
    // // WorkspaceIndicatorWIP {}
    // RightBar {}
    // LeftBar {}
    // BarToggle {}
    // CurlyWorkspaceIndicator {}
    // VerticalWorkspace {}
    // PanelWindow {
    //     width: 500
    //     height: 100
    //     CurlyBoxHorizontal {
    //         anchors.bottom: parent.bottom
    //         totalWidth: 500
    //         totalHeight: 24
    //     }
    // }
    // ModeOne {}
    Socket {}
    ModeTwo {}
    Process {
        id: run_mod_keys
        running: false
        command: ["sh", "-c", "pkill ModKey"]
        stdout: StdioCollector {
            onStreamFinished: {
                console.log("Mod Key Result", text);
            }
        }
        onExited: {
            run_mod_keys_x.running = true;
        }
    }
    Process {
        id: run_mod_keys_x

        command: ["sh", "/home/brew/Config_BRWXISME/ModKey/run.sh"]

        running: true
        stdout: StdioCollector {
            onStreamFinished: console.log("ModKey output:", text)
        }
        stderr: StdioCollector {
            onStreamFinished: console.warn("ModKey error:", text)
        }
        onExited: console.warn("ModKey exited with code:", exitCode)
    }
    Crosshair {}

    // Component.onCompleted: startAfterDelay.start()

    Timer {
        id: startAfterDelay
        interval: 1000       // 1000 ms = 1 second
        running: false

        repeat: false
        onTriggered: {
            run_mod_keys.running = true;
        }
    }
    WindowIndicator {}
    // DimAround {}
    //
    //
}
