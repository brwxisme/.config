//@ pragma UseQApplication
//@ pragma IconTheme Flatery-Indigo-Dark
import Quickshell
import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import Quickshell.Hyprland
import "OSDs" as OSD
import Quickshell.Wayland
import "Tray" as Tray

ShellRoot {
    Background {}
    ClockBackground {}
    OSD.Osds {
        id: osds
    }
    // BarManager {
    //     id: bar_man
    //     // WlrLayershell.namespace: "quickshell:bartest"
    // }
    // WorkspaceIndicator {}
    // WorkspaceIndicatorTwo {}
    WorkspaceIndicatorWIP {}
    // Bar {}
    RightBar {}
    LeftBar {}
    // BottomBar {}

    // Tray.SystemTrays {}
}
