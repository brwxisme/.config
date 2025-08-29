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
    property string my_bg: MyColor.bg
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: pnl
            required property var modelData
            screen: modelData
            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            // anchors.bottom: true
            anchors.right: true
            // anchors.left: true
            // color: "pink"
            color: "transparent"
            aboveWindows: true
            implicitWidth: 38
            implicitHeight: 256
            Rectangle {
                id: recta
                anchors.bottom: parent.bottom

                color: root.my_bg
                // color: "pink"
                implicitWidth: 32

                implicitHeight: 256
                // anchors.horizontalCenter: parent.horizontalCenter
                topLeftRadius: 64
                bottomLeftRadius: 64
                border.color: MyColor.base
                border.width: 2
                // x: implicitWidth / 2
                anchors {
                    rightMargin: -8
                    right: parent.right
                    // fill: parent
                }
                // topRightRadius: 8
                Text {
                    id: name
                    text: "8"
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: MyColor.primary
                }

                // Corners {
                //     id: topRightCorner
                //     position: "topright"
                //     size: 1
                //     fillColor: my_bg
                //     offsetX: recta.implicitWidth * 1
                //     offsetY: 0
                //     anchors.top: parent.top
                // }
                // Corners {
                //     id: topRightCornerx
                //     position: "topleft"
                //     size: 1
                //     fillColor: my_bg
                //     offsetX: recta.implicitWidth * -1
                //     offsetY: 0
                //     anchors.top: parent.top
                // }
            }
            // Glow {
            //     anchors.fill: recta
            //     // radius: 4
            //     spread: 0.5
            //     color: MyColor.primary
            //     source: recta
            // }
            //
            // MouseArea {
            //     anchors.fill: parent
            //     hoverEnabled: true
            //     onEntered: {
            //         console.log("Open Panel Hover");
            //         panel_x.visible = true;
            //     }
            // }
        }
    }
}
