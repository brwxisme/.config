//@ pragma UseQApplication
//@ pragma IconTheme Flatery-Indigo-Dark
import Quickshell
import QtQuick
import "../OSDs" as OSD
import "../Components"
import ".." as QR

ShellRoot {
    QR.Background {}
    QR.ClockBackground {}
    OSD.Osds {
        id: osds
    }
    WorkspaceIndicatorWIP {}
    RightBar {}
    LeftBar {}
    QR.BarToggle {}
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
}
