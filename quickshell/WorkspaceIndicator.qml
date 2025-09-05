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
    property bool on_bot: true
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: pnl
            required property var modelData
            property HyprlandMonitor myMonitor: Hyprland.monitorFor(screen)
            property HyprlandWorkspace myWorkspace: myMonitor.activeWorkspace
            property bool monitor_focus: myMonitor.focused

            onMonitor_focusChanged: {
                // myMonitor.onFocusedChanged: {

                recta.border.color = myMonitor.focused ? MyColor.primary : MyColor.base;
                console.log("aaaaaaaaa");
            }

            screen: modelData
            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            anchors.bottom: on_bot ? true : false
            anchors.top: !on_bot ? true : false
            color: "transparent"
            aboveWindows: true
            implicitWidth: recta.implicitWidth + 32
            implicitHeight: recta.implicitHeight
            Rectangle {
                id: recta
                color: root.my_bg
                implicitWidth: 256
                implicitHeight: 26
                topLeftRadius: on_bot ? 64 : 0
                topRightRadius: on_bot ? 64 : 0
                bottomLeftRadius: !on_bot ? 64 : 0
                bottomRightRadius: !on_bot ? 64 : 0
                border.color: MyColor.primary
                border.width: 2
                y: on_bot ? 4 : -4
                anchors.horizontalCenter: parent.horizontalCenter
                // anchors {
                //     bottomMargin: -4
                //     bottom: parent.bottom
                // }
                // topRightRadius: 8
                // Text {
                //     id: name
                //     text: "8"
                //     anchors.horizontalCenter: parent.horizontalCenter
                //     color: MyColor.primary
                // }
                WS.Workspaces {
                    scrn: modelData
                }
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    console.log("etnein");
                    root.on_bot = !root.on_bot;
                }
            }
            Behavior on anchors.top {
                NumberAnimation {
                    duration: 0
                    easing.type: Easing.OutBack
                }
            }
            Behavior on anchors.bottom {
                NumberAnimation {
                    duration: 0
                    easing.type: Easing.OutBack
                }
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
