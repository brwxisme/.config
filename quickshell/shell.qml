import Quickshell
import QtQuick
import QtQuick.Layouts
import "OSDs" as OSD
import Quickshell.Wayland
import "Workspace" as WS

ShellRoot {
    // Bar {}
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
    OverlayWorkspace {}
    WorkspaceIndicator {}
    // BottomBar {}
}
