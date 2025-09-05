import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell
import QtQuick

PanelWindow {
    color: "transparent"
    implicitWidth: 256
    implicitHeight: 256
    Rectangle {

        anchors.fill: parent
        // HyprlandWindow.opacity: 0.8
        // color: "transparent"
        color: "black"
        // color: "#800000FF"
        // color: rgb(0, 0, 0)

        // color.a: 0.5
        WlrLayershell.namespace: "quickshell:bartest"
    }
}
