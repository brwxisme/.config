pragma ComponentBehavior: Bound
import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell
import QtQuick
import QtQuick.Effects
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

            property bool on_bot: true
            property bool must_on_bot: true
            onOn_botChanged: {
                pnl.visible = false;
                temp_hide.restart();
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

            screen: modelData
            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            anchors.bottom: on_bot ? true : false
            anchors.top: !on_bot ? true : false
            color: "transparent"
            // color: "pink"
            aboveWindows: true
            implicitWidth: recta.implicitWidth + 8
            implicitHeight: recta.implicitHeight

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onDoubleClicked: {
                    pnl.must_on_bot = !pnl.must_on_bot;
                    on_bot = !on_bot;
                }
                onClicked: {
                    if (mouse.button === Qt.RightButton) {
                        console.log("Right button clicked!");
                        on_bot = !on_bot;
                        // Perform actions specific to right-click
                    }
                }
                // onEntered: {
                //     console.log("etnein");
                //     // on_bot = !on_bot;
                // }
            }
            Rectangle {
                id: recta
                color: root.my_bg
                implicitWidth: 256 - 32
                implicitHeight: 26

                topLeftRadius: pnl.on_bot ? 64 : 0
                topRightRadius: pnl.on_bot ? 64 : 0
                bottomLeftRadius: !pnl.on_bot ? 64 : 0
                bottomRightRadius: !pnl.on_bot ? 64 : 0

                // border.color: MyColor.primary
                border.color: Globals.window_count[modelData.name] == 0 ? "transparen" : MyColor.pink
                border.width: 2
                // y: getY()
                y: pnl.on_bot ? 4 : -4

                anchors.horizontalCenter: parent.horizontalCenter

                Workspace {
                    id: ws
                    scrn: pnl.modelData
                    // anchors.top: parent.top
                    y: 12
                }
                Behavior on border.color {
                    ColorAnimation {
                        duration: 250
                        easing.type: Easing.Linear
                    }
                }
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
                    updatePos();
                }
                function onShowOnEmptyWorkspace(): void {
                    // pnl.visible = Globals.window_count[modelData.name] != 0;
                    updatePos();
                }
            }
            function updatePos(): void {
                // pnl.must_on_bot = true;
                recta.border.color = Globals.window_count[modelData.name] != 0 ? MyColor.primary : "transparent";
                pnl.on_bot = pnl.must_on_bot;
            // recta.y = getY();
            }
            function getY(): void {
                if (Globals.window_count[modelData.name] == 0) {
                    return 0;
                } else {
                    return pnl.on_bot ? 10 : -10;
                }
            }
        }
    }
}
