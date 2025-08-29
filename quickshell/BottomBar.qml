import QtQuick
import Quickshell.Wayland
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
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
                bottom: true
            }

            implicitHeight: rect.implicitHeight
            color: "transparent"
            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            implicitWidth: 512
            Rectangle {
                id: rect
                // anchors.fill: parent
                anchors.top: parent.top
                // topRightRadius: 32
                // topLeftRadius: 32
                radius: 512
                color: MyColor.bg
                border.color: MyColor.base
                border.width: 2
                implicitHeight: 26
                anchors {
                    fill: parent
                    bottomMargin: implicitHeight * -1 * 1
                }

                Text {
                    font.family: "Fira Code"
                    font.weight: 600
                    color: MyColor.primary
                    anchors {
                        top: parent.top
                        // verticalCenter: parent.verticalCenter
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
