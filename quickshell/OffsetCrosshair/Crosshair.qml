import QtQuick
import QtQuick.Shapes 1.9
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell
import QtQuick
import ".."

Scope {
    id: root
    // property string my_bg: MyColor.bg
    property string my_bg: "#FF00FF"
    property int legth: 150

    property int thick: 2
    property int gap: 2
    property bool dot: false
    Variants {
        model: Quickshell.screens
        Item {
            required property var modelData
            PanelWindow {
                id: pnl
                implicitWidth: 250
                implicitHeight: 250
                screen: modelData
                visible: false

                WlrLayershell.layer: WlrLayer.Overlay
                color: "transparent"
                mask: Region {}
                exclusiveZone: 0
                // anchors.left: true
                Rectangle {
                    id: gap
                    anchors {
                        centerIn: parent
                        topMargin: 50
                        verticalCenterOffset: -2
                        // horizontalCenter: parent.horizontalCenter
                        // verticalCenter: parent.verticalCenter
                    }
                    implicitWidth: root.gap
                    implicitHeight: root.gap
                    color: root.dot ? root.my_bg : "transparent"

                    Rectangle {
                        anchors.right: parent.left
                        anchors {
                            rightMargin: root.gap
                        }
                        implicitWidth: root.legth
                        implicitHeight: root.thick
                        color: root.my_bg
                    }
                    Rectangle {
                        anchors.left: parent.right
                        anchors {
                            leftMargin: root.gap
                        }
                        implicitWidth: root.legth
                        implicitHeight: root.thick
                        color: root.my_bg
                    }
                    Rectangle {
                        anchors.top: parent.bottom
                        anchors {
                            topMargin: root.gap
                        }
                        implicitHeight: root.legth
                        implicitWidth: root.thick
                        color: root.my_bg
                    }
                }
                Connections {
                    target: Globals

                    function onShowCrosshairChanged(): void {
                        pnl.visible = Globals.showCrosshair;
                    }
                }
                // function updateOnWindowCount(): void {
                //     curly.borderColor = Globals.window_count[modelData.name] != 0 ? MyColor.primary : "transparent";
                // }
            }
        }
    }
}
