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
                margins.left: 16
                // anchors.mar: 128
                anchors {
                    bottom: true
                    left: true
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
                    totalWidth: stats.implicitWidth + 80
                    totalHeight: 20
                    Rectangle {
                        anchors.centerIn: parent

                        anchors.fill: parent
                        color: "transparent"
                        // implicitWidth: 256
                        height: 20
                        Stat.Stats {
                            id: stats
                            anchors.horizontalCenter: parent.horizontalCenter
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
