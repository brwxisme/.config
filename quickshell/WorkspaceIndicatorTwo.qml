pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell
import QtQuick
import "Workspace"

Scope {
    id: root
    property string my_bg: MyColor.bg
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: pnl

            required property var modelData
            property HyprlandMonitor myMonitor: Hyprland.monitorFor(screen)
            property HyprlandWorkspace myWorkspace: myMonitor.activeWorkspace
            property bool monitor_focus: myMonitor.focused

            property bool on_bot: false
            property bool must_on_bot: false
            onOn_botChanged: {
                // pnl.visible = false;
                // temp_hide.restart();
                if (on_bot != must_on_bot) {
                    back_on_top.restart();
                }
            }
            Timer {
                id: back_on_top
                interval: 3000
                onTriggered: on_bot = must_on_bot
            }
            Timer {
                id: temp_hide
                interval: 100
                onTriggered: {
                    pnl.visible = true;
                }
            }
            onMonitor_focusChanged: {
                // myMonitor.onFocusedChanged: {

                // recta.border.color = myMonitor.focused ? MyColor.primary : MyColor.base;
                console.log("aaaaaaaaa");
            }

            screen: modelData
            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.exclusionMode: ExclusionMode.Ignore

            anchors.bottom: on_bot ? true : false
            anchors.top: !on_bot ? true : false

            // anchors.bottom: true

            color: "transparent"
            // color: "pink"

            aboveWindows: true
            implicitWidth: recta.implicitWidth + 32
            // implicitHeight: recta.implicitHeight + 8
            implicitHeight: 32
            Rectangle {
                id: recta
                color: root.my_bg
                // color: "transparent"
                implicitWidth: 256
                implicitHeight: 22

                topLeftRadius: pnl.on_bot ? 64 : 0
                topRightRadius: pnl.on_bot ? 64 : 0
                bottomLeftRadius: !pnl.on_bot ? 64 : 0
                bottomRightRadius: !pnl.on_bot ? 64 : 0
                // radius: 64

                border.color: pnl.must_on_bot ? MyColor.primary : "transparent"
                // border.color: MyColor.pink
                // border.color: "transparent"
                border.width: 1
                y: on_bot ? 12 : -2
                anchors.horizontalCenter: parent.horizontalCenter
                // anchors.verticalCenter: parent.verticalCenter

                Workspace {
                    scrn: pnl.modelData
                }
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onDoubleClicked: {
                    if (pnl.must_on_bot) {
                        on_bot = !on_bot;
                    }
                }
                // onEntered: {
                //     console.log("etnein");
                //     if (pnl.must_on_bot) {
                //         on_bot = !on_bot;
                //     }
                // }
            }
            Behavior on anchors.top {
                PropertyAnimation {
                    duration: 0
                }
            }
            Behavior on anchors.bottom {
                NumberAnimation {
                    duration: 0
                }
            }
            Connections {
                target: Globals

                function onShowWorkspaces(): void {
                    pnl.must_on_bot = Globals.window_count[modelData.name] != 0;
                    pnl.on_bot = pnl.must_on_bot;
                // pnl.visible = Globals.window_count[modelData.name] != 0;
                }
                function onShowOnEmptyWorkspace(): void {
                    pnl.must_on_bot = Globals.window_count[modelData.name] != 0;
                    pnl.on_bot = pnl.must_on_bot;
                // pnl.visible = Globals.window_count[modelData.name] != 0;
                }
            }
        }
    }
}
