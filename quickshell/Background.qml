import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell
import QtQuick

Scope {
    id: root
    property string my_bg: MyColor.darkest
    property int size: 512 + 256
    Variants {
        model: Quickshell.screens
        // model: Hyprlan.monitors
        Item {
            required property var modelData

            PanelWindow {
                id: bar_man
                screen: modelData

                // visible: modelData.name == "HDMI-A-1"

                WlrLayershell.layer: WlrLayer.Background
                WlrLayershell.exclusionMode: ExclusionMode.Ignore
                anchors {
                    top: true
                    left: true
                    right: true
                    bottom: true
                }
                color: MyColor.bg

                Rectangle {
                    implicitWidth: root.size
                    implicitHeight: root.size
                    anchors.centerIn: parent
                    color: "transparent"
                    Image {
                        id: name

                        anchors.centerIn: parent
                        // anchors.fill: parent
                        mipmap: true
                        source: "/home/brew/Pictures/CenterPicture/ChopperFranky.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
        }
    }
}
