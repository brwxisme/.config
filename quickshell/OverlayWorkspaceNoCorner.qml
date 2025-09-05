import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell
import QtQuick
import Qt5Compat.GraphicalEffects // For Qt 5 compatibility
import "Workspace" as WS
import QtQuick.Effects
import Quickshell.Wayland

Item {
    id: ws_left
    implicitWidth: 256 + 32
    height: 24
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {
        id: recta

        anchors.top: parent.top
        // anchors.topMargin: -4

        implicitWidth: 256
        implicitHeight: 20
        color: my_bg
        // color: "transparent"
        // color: "#00000022"
        // anchors.horizontalCenter: parent.horizontalCenter
        // bottomLeftRadius: 32
        // bottomRightRadius: 32
        radius: 32

        WS.Workspaces {

            scrn: modelData
            implicitHeight: 32
        }
        border.color: MyColor.base
        border.width: 1
    }
}
