pragma ComponentBehavior: Bound
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell
import Quickshell.Hyprland
import QtQuick
import "../Workspace"
import "../Tray" as Tray
import "../SystemStats" as Stat
import "../Components"
import ".."

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
                // color: "pink"
                implicitHeight: recta.implicitHeight + 4
                implicitWidth: recta.implicitWidth
                screen: modelData
                margins.right: 16
                // anchors.mar: 128
                anchors {
                    bottom: true
                    right: true
                }
                onShowChanged: {
                    if (show) {
                        margins.bottom = 0;
                    } else {
                        margins.bottom = -32;
                    }
                }

                CurlyBoxHorizontal {
                    id: recta
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    // totalWidth: 256 + 16
                    totalWidth: row.implicitWidth + 64
                    totalHeight: 20

                    Rectangle {
                        color: "transparent"
                        implicitWidth: row.implicitWidth + 0
                        // minimumWidth: 320
                        height: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        Row {
                            id: row
                            anchors.horizontalCenter: parent.horizontalCenter
                            // anchors.right: parent.right
                            Tray.TrayList {
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Item {
                                implicitWidth: 8
                                implicitHeight: 8
                            }
                            // IconButton {
                            //     icon: ""
                            //     icon_color: "white"
                            //     command: ["hyprpicker", "-a"]
                            // }
                            HyprPicker {}
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
                }
            }
            Connections {
                target: Globals

                function onShowWorkspaces(): void {
                    updateOnWindowCount();
                }
                function onShowOnEmptyWorkspace(): void {
                    updateOnWindowCount();
                }
                function onShowBar(val: string): void {
                    if (modelData.name == val) {
                        bar.show = Globals.showingBar;

                        // recta.border.color = Globals.window_count[modelData.name] != 0 ? MyColor.primary : "transparent";
                        recta.borderColor = Globals.window_count[modelData.name] != 0 ? MyColor.primary : "transparent";
                    }
                }
            }
            function updateOnWindowCount(): void {
                bar.show = Globals.window_count[modelData.name] == 0;
                // time.visible = Globals.window_count[modelData.name] != 0;
                if (bar.show) {
                    // recta.border.color = Globals.window_count[modelData.name] != 0 ? MyColor.primary : "transparent";
                    recta.borderColor = Globals.window_count[modelData.name] != 0 ? MyColor.primary : "transparent";
                }
            }
        }
    }
}
