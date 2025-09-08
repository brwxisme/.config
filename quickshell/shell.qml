//@ pragma UseQApplication
//@ pragma IconTheme Flatery-Indigo-Dark
import Quickshell
import QtQuick
import "OSDs" as OSD

ShellRoot {
    Background {}
    ClockBackground {}
    OSD.Osds {
        id: osds
    }
    WorkspaceIndicatorWIP {}
    RightBar {}
    LeftBar {}
    BarToggle {}
}
