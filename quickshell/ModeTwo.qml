//@ pragma UseQApplication
//@ pragma IconTheme Flatery-Indigo-Dark
import Quickshell
import QtQuick
import "OSDs" as OSD
import "VerticalWorkspace"
import "Components"

ShellRoot {
    Background {}
    ClockBackground {}
    OSD.Osds {
        id: osds
    }
    BottomBar {}
    BarToggle {}
    VerticalWorkspace {}
}
