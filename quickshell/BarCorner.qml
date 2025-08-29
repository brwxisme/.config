pragma ComponentBehavior: Bound
import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Wayland
import Quickshell
import QtQuick
import QtQuick.Effects
import "Workspace" as WS

Scope {
    id: root
    property string kek
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: panel

            required property var modelData
            screen: modelData
            // property string my_bg: MyColor.purple
            property string my_bg: MyColor.darkest

            // anchors.top: true
            // anchors.left: true
            anchors {
                top: true
                left: true
                right: true
            }
            color: "transparent"
            // margins.top: 64
            // WlrLayershell.exclusionMode: ExclusionMode.Ignore
            // visible: true
            // WlrLayershell.layer: WlrLayer.Background

            implicitHeight: 20
            // implicitWidth: 320 + 64

            Item {
                id: ws_left
                implicitWidth: 256 + 32
                // implicitHeight: 24
                height: 20
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle {
                    id: recta
                    // x: -4

                    anchors.top: parent.top

                    implicitWidth: 256
                    implicitHeight: 18
                    color: my_bg
                    anchors.horizontalCenter: parent.horizontalCenter
                    bottomLeftRadius: 16
                    bottomRightRadius: 16
                    WS.Workspaces {
                        scrn: modelData
                        // my_base: MyColor.dark
                        implicitHeight: 20
                    }
                    // layer.enabled: true
                    // layer.effect: MultiEffect {
                    //     shadowEnabled: true
                    //     // blurMax: 24
                    //     shadowColor: MyColor.green
                    //     shadowScale: 1
                    // }
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
            // MultiEffect {
            //     source: ws_left
            //     shadowEnabled: true
            //     shadowColor: MyColor.green
            //     anchors.fill: ws_left
            //     shadowScale: 1
            //     shadowBlur: 2
            //     blurMax: 16
            //     // shadowVerticalOffset: 2
            // }
        }
        // PanelWindow {
        //     color: "red"
        //     WlrLayershell.layer: WlrLayer.Overlay
        //     WlrLayershell.exclusionMode: ExclusionMode.Ignore
        //     anchors.top: true
        //     // anchors.left: true
        //     aboveWindows: true
        //     Rectangle {
        //         anchors.fill: parent
        //         color: "pink"
        //     }
        //     MouseArea {
        //         anchors.fill: parent
        //         hoverEnabled: true
        //         onEntered: {
        //             console.log("eee");
        //             root.panel.visible = true;
        //         }
        //
        //         onExited: {
        //             console.log("o");
        //             root.panel.visible = false;
        //         }
        //     }
        // }
    }
}
