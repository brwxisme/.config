pragma ComponentBehavior: Bound
import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import Quickshell
import QtQuick
import ".."

Scope {
    id: root
    property string kek
    property string my_bg: MyColor.darkest

    Connections {
        target: Hyprland
        function onFocusedWorkspaceChanged(a): void {
            // function onActiveWsIdChanged(): void {
            console.log("lalal");
        }
        function onRawEvent(event: HyprlandEvent): void {
            const e_name = event.name;
        // console.log(e_name, "  ", event.data);
        }
    }
    Variants {
        model: Quickshell.screens
        Item {
            required property var modelData

            // Timer {
            //     id: hideTimer
            //     interval: 2000
            //     onTriggered: panel_x.visible = false
            // }
            PanelWindow {
                id: panel_x

                WlrLayershell.layer: WlrLayer.Background
                WlrLayershell.exclusionMode: ExclusionMode.Ignore
                visible: true
                screen: modelData
                // property string my_bg: MyColor.purple
                anchors {
                    top: true
                    // left: true
                    right: true
                    // bottom: true
                }

                color: "pink"

                implicitHeight: 24
                implicitWidth: ws_left.implicitWidth
                Item {
                    id: ws_left
                    implicitWidth: 256 + 32
                    height: 24
                    y: 4
                    Rectangle {
                        id: recta

                        anchors.right: parent.right
                        x: 32

                        implicitWidth: rows.implicitWidth + 16
                        implicitHeight: 20
                        // color: "pink"
                        color: "transparent"
                        // anchors.horizontalCenter: parent.horizontalCenter
                        // bottomLeftRadius: 32
                        // bottomRightRadius: 32
                        radius: 32
                        border.color: MyColor.base
                        border.width: 1
                        Row {
                            id: rows
                            anchors.fill: parent
                            anchors.centerIn: parent
                            leftPadding: 8
                            // TrayItemA {}
                            Repeater {
                                id: items
                                model: SystemTray.items
                                TrayItem {}
                            }
                            Component.onCompleted: {
                                console.log("Hello");
                                SystemTray.items.values.forEach(systray => {
                                    console.log(systray.id + ", " + systray.icon);
                                });
                            }
                        }
                    }
                }

                //     Glow {
                //         anchors.fill: ws_left
                //         // radius: 4
                //         spread: 0.5
                //         color: MyColor.violet
                //         source: ws_left
                //     }
                //
            }
        }
    }
}
