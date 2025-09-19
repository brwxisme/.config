//@ pragma UseQApplication
//@ pragma IconTheme Flatery-Indigo-Dark
import Quickshell
import QtQuick
import ".."
import "../OSDs" as OSD
import "../VerticalWorkspace"
import "../Components"

ShellRoot {
    Background {}
    // ClockBackground {}
    OSD.Osds {
        id: osds
    }

    LeftBar {}

    BottomBar {}
    RightBar {}
    BarToggle {}
    VerticalWorkspace {}
}
