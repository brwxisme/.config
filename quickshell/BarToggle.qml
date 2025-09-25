pragma ComponentBehavior: Bound
import Quickshell.Io
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell
import Quickshell.Hyprland
import QtQuick
import "Workspace"
import "Tray" as Tray
import "SystemStats" as Stat

Scope {
    id: root
    property string kek
    property string my_bg: MyColor.darkest
    property int windows: 0
    Variants {
        model: Quickshell.screens
        // model: Hyprlan.monitors
        Item {
            required property var modelData

            PanelWindow {
                id: bar
                WlrLayershell.layer: WlrLayer.Overlay
                WlrLayershell.exclusionMode: ExclusionMode.Ignore
                visible: true
                property bool show: true
                color: "transparent"
                // height: recta.implicitHeight + 4
                // implicitWidth: recta.implicitWidth + 32
                implicitHeight: 1
                screen: modelData
                anchors {
                    bottom: true
                    left: true
                    right: true
                }
                MouseArea {
                    anchors.fill: parent
                    onDoubleClicked: Globals.toggleBar()
                }
            }
        }
    }
}
