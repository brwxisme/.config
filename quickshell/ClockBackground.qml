import QtQuick
import Quickshell.Io
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

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
                screen: modelData
                WlrLayershell.layer: WlrLayer.Background
                WlrLayershell.exclusionMode: ExclusionMode.Ignore

                width: time.implicitWidth
                height: time.implicitHeight
                // HyprlandWindow.opacity: 0.6
                color: "transparent"
                anchors {
                    top: true
                    right: true
                    bottom: true
                    left: true
                }
                Rectangle {
                    id: container
                    implicitWidth: date.implicitWidth + 32
                    implicitHeight: 112
                    // color: MyColor.darkest
                    color: "transparent"
                    radius: 32
                    opacity: 1

                    anchors {
                        top: parent.top
                        horizontalCenter: parent.horizontalCenter
                        topMargin: Math.floor(modelData.height * 0.15)
                        // topMargin: 160
                        // margins: 96
                    }
                    Text {
                        id: time

                        font.family: "Fira Code"
                        font.weight: 600
                        font.pointSize: 36
                        antialiasing: true
                        // width: 320
                        // height: 8
                        color: MyColor.primary
                        // y: 24
                        // verticalCenter: parent.verticalCenter
                        // topMargin: 32
                        anchors {
                            bottom: parent.bottom
                            // right: parent.right
                            horizontalCenter: parent.horizontalCenter
                            topMargin: 8
                            // bottomMargin: 64
                        }
                        text: Globals.time
                        focus: true
                    }
                    Text {
                        id: date

                        // antialiasing: true
                        // visible: false
                        font.family: "Fira Code"
                        font.weight: 600
                        font.pointSize: 18
                        // style: Text.Outline
                        // styleColor: "red"
                        // width: 320
                        // height: 8
                        color: MyColor.primary
                        // y: time.implicitHeight
                        // verticalCenter: parent.verticalCenter
                        // topMargin: 32

                        anchors {
                            top: parent.top
                            margins: 16
                            horizontalCenter: parent.horizontalCenter
                            // topMargin: time.implicitHeight / 2
                        }
                        text: Globals.date
                        focus: true
                    }
                    Behavior on opacity {
                        OpacityAnimator {
                            duration: 500
                            easing.type: Easing.Linear
                        }
                    }
                }
            }
            Connections {
                target: Globals

                function onShowWorkspaces(): void {
                    updatePos();
                }
                function onShowOnEmptyWorkspace(): void {
                    // pnl.visible = Globals.window_count[modelData.name] != 0;
                    updatePos();
                }
            }
            function updatePos(): void {
                // container

                container.opacity = Globals.window_count[modelData.name] == 0 ? 1 : 0;

            // recta.y = getY();
            }
        }
    }
}
