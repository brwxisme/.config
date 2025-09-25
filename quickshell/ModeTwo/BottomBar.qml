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
                implicitWidth: recta.implicitWidth + 32
                screen: modelData
                // margins.left: 32
                // anchors.mar: 128
                anchors {
                    // bottom: true
                    top: true
                }
                onShowChanged: {
                    if (show) {
                        margins.top = 0;
                    } else {
                        margins.top = -32;
                    }
                }

                CurlyBoxHorizontal {
                    id: recta
                    onBot: false
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    // totalWidth: 256 + 16
                    totalWidth: container.implicitWidth
                    // totalWidth: row.implicitWidth + 0
                    totalHeight: container.implicitHeight
                    Rectangle {
                        id: container
                        color: "transparent"
                        implicitWidth: 256 + 80
                        anchors.horizontalCenter: parent.horizontalCenter
                        // minimumWidth: 320
                        implicitHeight: 20
                        Text {
                            id: time
                            // visible: false
                            text: Globals.time + "  " + Globals.date
                            // text: "brew@nixos"
                            font.family: "Fira Code"
                            font.pointSize: 10
                            font.weight: 600
                            color: MyColor.primary
                            // anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            // anchors.topMargin: 32
                            y: 1
                            // minimumPointSize: 12
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
                    updateOnWindowCount();
                // if (modelData.name == val) {
                //     bar.show = Globals.showingBar;
                //
                //     // recta.border.color = Globals.window_count[modelData.name] != 0 ? MyColor.primary : "transparent";
                //     recta.borderColor = Globals.window_count[modelData.name] != 0 ? MyColor.primary : "transparent";
                // }
                }
            }
            function updateOnWindowCount(): void {
                bar.show = Globals.shouldShow(modelData.name);
                recta.borderColor = Globals.window_count[modelData.name] != 0 ? MyColor.primary : "transparent";
            }
            Component.onCompleted: updateOnWindowCount()
        }
    }
}
