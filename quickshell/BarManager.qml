pragma ComponentBehavior: Bound
import Quickshell.Io
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell
import Quickshell.Hyprland
import QtQuick
import "Workspace" as WS
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
                id: bar_man

                WlrLayershell.layer: WlrLayer.Overlay
                WlrLayershell.exclusionMode: ExclusionMode.Ignore
                // visible: false
                screen: modelData

                property HyprlandMonitor myMonitor: Hyprland.monitorFor(screen)
                property HyprlandWorkspace myWorkspace: myMonitor.activeWorkspace

                // onMyWorkspaceChanged: {
                //     console.log("Monitor ", myMonitor.name, "CHANGED WS TO ", myWorkspace.id);
                //     // getWindowCount.running = true;
                // }
                //
                // property string my_bg: MyColor.purple
                anchors {
                    top: true
                    left: true
                    right: true
                }

                color: "transparent"

                implicitHeight: 2

                MouseArea {
                    anchors.fill: parent
                    onDoubleClicked: {
                        bar.show = true;
                    }
                }

                Timer {
                    id: hideTimer
                    interval: 1000
                    onTriggered: {
                        if (bar_mouse.containsMouse) {
                            return;
                        }
                        bar.show = !Globals.monitors[modelData.name];
                    }
                }

                Connections {
                    target: Globals

                    function onShowWorkspaces(): void {
                        bar_man.open_ws_panel();
                    }
                    function onHideWorkspaces(): void {
                        bar.show = false;
                    }
                    function onShowOnEmptyWorkspace(): void {
                        if (bar_man.myWorkspace.focused == false) {
                            return;
                        }

                        showBasedWinCount.running = true;
                    // getWindowCount.running = true;
                    }
                }
                function open_ws_panel(): void {
                    bar.show = true;
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
                            bar.show = root.windows == 0;
                        }
                    }
                }
            }
            PanelWindow {
                id: bar
                WlrLayershell.layer: WlrLayer.Overlay
                WlrLayershell.exclusionMode: ExclusionMode.Ignore
                visible: true
                property bool show: true
                color: "transparent"
                height: 32
                screen: modelData
                margins.top: -8
                anchors {
                    top: true
                    left: true
                    right: true
                }
                onShowChanged: {
                    if (show) {
                        margins.top = 8;
                    } else {
                        margins.top = -32;
                    }
                }

                mask: Region {
                    Region {
                        item: ws
                    }
                    Region {
                        item: recta
                    }
                    // item: {
                    //     ws, recta;
                    // }
                }

                MouseArea {
                    id: bar_mouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onExited: hideTimer.restart()
                }

                Rectangle {
                    id: left_stat

                    anchors.left: parent.left
                    // anchors.leftMargin:32
                    anchors.leftMargin: 16

                    implicitWidth: row_left.implicitWidth + 32
                    implicitHeight: 20
                    // color: "transparent"
                    color: MyColor.bg
                    radius: 32
                    border.color: MyColor.base
                    border.width: 1
                    Row {
                        id: row_left
                        // anchors.fill: parent
                        // anchors.rightMargin: 32
                        x: 16
                        anchors.verticalCenter: parent.verticalCenter
                        // anchors.centerIn: parent
                        spacing: 16
                        Stat.Stats {}
                        ClockWidget {}
                    }
                }

                OverlayWorkspaceNoCorner {
                    id: ws
                }
                Rectangle {
                    id: recta

                    anchors.right: parent.right
                    anchors.rightMargin: 16

                    implicitWidth: row.implicitWidth + 8
                    implicitHeight: 20
                    // color: "transparent"
                    color: MyColor.bg
                    radius: 32
                    border.color: MyColor.base
                    border.width: 1
                    Row {
                        id: row
                        anchors.fill: parent
                        anchors.centerIn: parent
                        spacing: 0
                        Tray.TrayList {}
                        Item {
                            implicitWidth: 8
                            implicitHeight: 8
                        }
                        IconButton {
                            icon: ""
                            icon_color: "white"
                            command: ["hyprpicker", "-a"]
                        }
                        BackgroundButton {}
                        IconButton {
                            icon: ""
                            icon_color: MyColor.secondary
                            command: ["pavucontrol"]
                        }
                        PowerButton {
                            // color: "pink"
                            // implicitWidth: 32
                            implicitHeight: 16
                        }
                    }
                }

                Behavior on margins.top {
                    NumberAnimation {
                        duration: 125
                        easing.type: Easing.OutBack
                    }
                }
            }
            Component.onCompleted: {
                Globals.showOnEmptyWorkspace();
                bar_man.open_ws_panel();
            }
        }
    }
}
