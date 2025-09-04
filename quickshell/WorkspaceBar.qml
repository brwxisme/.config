pragma ComponentBehavior: Bound
import Quickshell.Io
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell
import Quickshell.Hyprland
import QtQuick
import "Workspace" as WS

Scope {
    id: root
    property string kek
    property string my_bg: MyColor.darkest
    property int windows: 0
    Variants {
        model: Quickshell.screens
        // model: Hyprland.monitors
        Item {
            required property var modelData

            PanelWindow {
                id: panel_x

                WlrLayershell.layer: WlrLayer.Overlay
                WlrLayershell.exclusionMode: ExclusionMode.Ignore
                visible: false
                screen: modelData

                property HyprlandMonitor myMonitor: Hyprland.monitorFor(screen)
                property HyprlandWorkspace myWorkspace: myMonitor.activeWorkspace

                onMyWorkspaceChanged: {
                    console.log("Monitor ", myMonitor.name, "CHANGED WS TO ", myWorkspace.id);
                    getWindowCount.running = true;
                }

                // property string my_bg: MyColor.purple
                anchors {
                    top: true
                    // left: true
                    // right: true
                }

                color: "transparent"

                implicitHeight: 24
                implicitWidth: ws_left.implicitWidth

                Component.onCompleted: {
                    my_monitor: Hyprland.monitorFor(panel_x.screen);
                    console.log("CCCCCCCCCCCCCCCCCC");

                    console.log(panel_x.my_monitor.id);
                }

                Timer {
                    id: hideTimer
                    interval: 1000
                    onTriggered: {
                        panel_x.visible = !Globals.monitors[modelData.name];
                        console.log(modelData.name, " visible = ", !Globals.monitors[modelData.name]);
                    }
                }

                Item {
                    id: ws_left
                    implicitWidth: 256 + 32
                    height: 24
                    y: 4
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle {
                        id: recta

                        anchors.top: parent.top
                        // anchors.topMargin: -4

                        implicitWidth: 256
                        implicitHeight: 20
                        color: my_bg
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

                Connections {
                    target: Globals

                    function onShowWorkspaces(): void {
                        panel_x.open_ws_panel();
                    }
                    function onHideWorkspaces(): void {
                        panel_x.visible = false;
                    }
                    function onShowOnEmptyWorkspace(): void {
                        console.log(panel_x.myMonitor.name, "aaaaaaaa ", panel_x.myWorkspace.focused);
                        if (panel_x.myWorkspace.focused == false) {
                            return;
                        }

                        showBasedWinCount.running = true;
                        // getWindowCount.running = true;
                        console.log("OIIOIOI ", root.windows);
                    }
                }
                function open_ws_panel(): void {
                    panel_x.visible = true;
                    if (Globals.monitors[modelData.name]) {
                        hideTimer.restart();
                    }
                }
                Process {
                    id: showBasedWinCount
                    command: ["hyprctl", "activeworkspace", "-j"]
                    running: true

                    stdout: StdioCollector {
                        onStreamFinished: {
                            var x = JSON.parse(text);
                            root.windows = x.windows;
                            panel_x.visible = root.windows == 0;
                        }
                    }
                }
            }
        }
    }
    Process {
        id: getWindowCount
        command: ["hyprctl", "activeworkspace", "-j"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                var x = JSON.parse(text);
                console.log("HHH", x.windows);
                root.windows = x.windows;
            }
        }
    }
}
