pragma ComponentBehavior: Bound
import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell
import QtQuick
import QtQuick.Effects
import "Workspace" as WS

Scope {
    id: root
    property string kek
    property string my_bg: MyColor.darkest
    Variants {
        model: Quickshell.screens
        Item {
            required property var modelData

            Connections {
                target: Hyprland

                function onRawEvent(event: HyprlandEvent): void {
                    const e_name = event.name;
                    const show = e_name.includes("work") || e_name.includes("mon");
                    if (show) {
                        open_ws_panel();
                    }
                // console.log(show);
                }
            }
            function open_ws_panel(): void {
                panel_x.visible = true;
                hideTimer.restart();
            }
            Timer {
                id: hideTimer
                interval: 2000
                onTriggered: panel_x.visible = false
            }

            PanelWindow {
                screen: modelData
                color: "transparent"
                WlrLayershell.layer: WlrLayer.Top
                // WlrLayershell.exclusionMode: ExclusionMode.Ignore
                anchors.top: true
                aboveWindows: true
                implicitWidth: 256
                implicitHeight: 1
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        console.log("Open Panel Hover");
                        panel_x.visible = true;
                    }
                }
            }
            PanelWindow {
                id: panel_x

                WlrLayershell.layer: WlrLayer.Overlay
                WlrLayershell.exclusionMode: ExclusionMode.Ignore
                visible: false
                screen: modelData
                // property string my_bg: MyColor.purple
                anchors {
                    top: true
                    left: true
                    right: true
                }
                color: "transparent"

                implicitHeight: 20

                Item {
                    id: ws_left
                    implicitWidth: 256 + 32
                    height: 20
                    // y: -12
                    anchors.horizontalCenter: parent.horizontalCenter
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true

                        onExited: {
                            console.log("o");
                            panel_x.visible = false;
                        }
                    }

                    Rectangle {
                        id: recta

                        anchors.top: parent.top

                        implicitWidth: 256
                        implicitHeight: 18
                        color: my_bg
                        anchors.horizontalCenter: parent.horizontalCenter
                        bottomLeftRadius: 16
                        bottomRightRadius: 16
                        WS.Workspaces {
                            scrn: modelData
                            implicitHeight: 20
                        }
                    }
                    Corners {
                        id: topRightCorner
                        position: "bottomleft"
                        size: 0.75
                        fillColor: my_bg
                        offsetX: recta.implicitWidth - 23 + recta.x
                        offsetY: 0
                        anchors.top: parent.top
                    }
                    Corners {
                        id: topRightCornerx
                        position: "bottomright"
                        size: 0.75
                        fillColor: my_bg
                        offsetX: (recta.implicitWidth * -1) + 7
                        offsetY: 0
                        anchors.top: parent.top
                    }
                }

                Glow {
                    anchors.fill: ws_left
                    // radius: 4
                    spread: 0.5
                    color: MyColor.violet
                    source: ws_left
                }
            }
        }
    }
}
