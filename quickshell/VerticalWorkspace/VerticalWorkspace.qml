pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell
import QtQuick
import ".."

Scope {
    id: root
    property string my_bg: MyColor.bg
    Variants {
        model: Quickshell.screens
        Item {
            required property var modelData
            PanelWindow {
                id: pnl
                screen: modelData

                WlrLayershell.layer: WlrLayer.Top
                WlrLayershell.exclusionMode: ExclusionMode.Ignore
                property HyprlandMonitor myMonitor: Hyprland.monitorFor(screen)
                property HyprlandWorkspace myWorkspace: myMonitor.activeWorkspace
                property bool monitor_focus: myMonitor.focused

                property bool inverted: false
                onInvertedChanged: {
                    visible = false;
                    temp_hide.restart();
                    if (inverted) {
                        anchors.left = screen.name != "HDMI-A-1";
                        anchors.right = screen.name != "DP-2";
                    } else {
                        anchors.left = screen.name == "HDMI-A-1";
                        anchors.right = screen.name == "DP-2";
                    }
                    curly.inverted = inverted;
                }

                // anchors.left: true
                anchors.left: screen.name == "HDMI-A-1"
                anchors.right: screen.name == "DP-2"
                implicitHeight: curly.implicitHeight + 64
                width: curly.totalWidth
                color: "transparent"

                CurlyBox {
                    id: curly
                    totalHeight: container.implicitHeight + 64
                    totalWidth: 20
                    // onLeft: true
                    onLeft: modelData.name == "HDMI-A-1"

                    // anchors.left: parent.left
                    anchors.left: onLeft ? parent.left : undefined
                    anchors.right: !onLeft ? parent.right : undefined
                    anchors.verticalCenter: parent.verticalCenter
                    WorkspaceButtonContainer {
                        id: container
                        // implicitHeight: parent.implicitHeight
                        // implicitWidth: 20
                        // color: "pink"
                        scrn: modelData
                        // anchors.fill: parent
                        // anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                Timer {
                    id: back_to_original
                    interval: 3000
                    onTriggered: pnl.inverted = false
                }
                Timer {
                    id: temp_hide
                    interval: 100
                    onTriggered: pnl.visible = true
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    propagateComposedEvents: true

                    onEntered: {
                        if (Globals.showingBar) {
                            return;
                        }
                        pnl.inverted = !pnl.inverted;
                        back_to_original.restart();
                    }
                }

                Connections {
                    target: Globals

                    function onShowWorkspaces(): void {
                        pnl.updateOnWindowCount();
                    }
                    function onShowOnEmptyWorkspace(): void {
                        pnl.updateOnWindowCount();
                    }
                }
                function updateOnWindowCount(): void {
                    curly.borderColor = Globals.window_count[modelData.name] != 0 ? MyColor.primary : "transparent";
                }
            }
        }
    }
}
