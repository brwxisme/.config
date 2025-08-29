import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Hyprland
import "Workspace" as WS
import "SystemStats" as SS

Scope {
    id: root
    property string time
    property string is_caps_on
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property var modelData
            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30
            color: MyColor.bg
            Rectangle {
                implicitWidth: 160
                x: 12
                anchors {
                    verticalCenter: parent.verticalCenter
                }
                WS.Workspaces {

                    anchors {
                        verticalCenter: parent.verticalCenter
                    }
                    scrn: modelData
                    implicitWidth: 256
                }
            }

            Rectangle {
                anchors.fill: parent
                radius: height / 3
                color: "transparent"
                border.color: MyColor.base
                border.width: 2
                anchors {
                    fill: parent
                    margins: 4
                }
                Text {
                    font.family: "Fira Code"
                    font.weight: 600
                    color: MyColor.primary
                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                    text: root.time
                    focus: true
                }
            }

            SS.Stats {}
        }
    }
    Process {
        id: dateProc
        command: ["date", "+%A %H:%M"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.time = this.text
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}
