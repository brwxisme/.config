pragma ComponentBehavior: Bound
import Quickshell.Io
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell
import Quickshell.Hyprland
import QtQuick
import "../Workspace"
import "../Tray" as Tray
import "../SystemStats" as Stat
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
                height: recta.implicitHeight + 4
                implicitWidth: recta.implicitWidth + 32
                screen: modelData
                // margins.top: -8
                anchors {
                    bottom: true
                    right: true
                }
                onShowChanged: {
                    if (show) {
                        margins.right = 8;
                    } else {
                        margins.right = (recta.implicitWidth + 28) * -1;
                    }
                }

                mask: Region {
                    Region {
                        item: left_stat
                    }
                    Region {
                        item: recta
                    }
                }

                Rectangle {
                    id: recta

                    anchors.right: parent.right
                    // anchors.rightMargin: 16

                    // y: -2
                    anchors.rightMargin: 8
                    implicitWidth: row.implicitWidth + 8
                    implicitHeight: row.implicitHeight + 4
                    // color: "transparent"
                    color: MyColor.bg
                    // radius: 32
                    topLeftRadius: 64
                    topRightRadius: 64
                    // border.color: MyColor.primary
                    border.color: "transparent"
                    border.width: 2
                    y: 6
                    Row {
                        id: row
                        anchors.fill: parent
                        anchors.centerIn: parent
                        // anchors.bottomMargin: 8
                        spacing: 0
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
                        bar.show = !bar.show;

                        recta.border.color = Globals.window_count[modelData.name] != 0 ? MyColor.primary : "transparent";
                    }
                }
            }
            function updateOnWindowCount(): void {
                bar.show = Globals.window_count[modelData.name] == 0;
                if (bar.show) {
                    recta.border.color = Globals.window_count[modelData.name] != 0 ? MyColor.primary : "transparent";
                }
            }
        }
    }
}
