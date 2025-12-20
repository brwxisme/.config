pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell
import ".."

Scope {
    id: root

    property string clr: MyColor.green
    property string bg_clr: MyColor.bg

    // property string bg_clr: "transparent"
    property var pressed_mod: []
    // property var pressed_mod: ["CTRL", "META", "ALT"]
    property int square_size: 128
    property int icon_size: 48

    LazyLoader {
        id: ll
        // active: true
        // active: root.pressed_mod.length != 0
        //
        active: true

        Variants {
            id: v
            model: Quickshell.screens
            PanelWindow {
                // Since the panel's screen is unset, it will be picked by the compositor
                // when the window is created. Most compositors pick the current active monitor.
                id: pnl
                required property var modelData
                screen: modelData
                property HyprlandMonitor myMonitor: Hyprland.monitorFor(screen)
                property HyprlandWorkspace myWorkspace: myMonitor.activeWorkspace
                property bool monitor_focus: myMonitor.focused
                property int pos_x: 0
                property int pos_y: 0
                property int window_x: 0
                property int window_y: 0
                property int screen_w: 0
                property int screen_h: 0
                property bool show_me: false
                anchors.top: true
                anchors.left: true
                visible: show_me

                // margins.bottom: modelData.height * 0.25
                WlrLayershell.layer: WlrLayer.Overlay
                // anchor.centerIn :parent
                margins.left: window_x - (root.square_size / 2)
                margins.top: window_y - (root.square_size / 2)

                exclusiveZone: 0

                implicitWidth: root.square_size
                // implicitWidth: row.implicitWidth
                implicitHeight: root.square_size
                color: "transparent"

                // An empty click mask prevents the window from blocking mouse events.
                mask: Region {}
                Connections {
                    target: Globals
                    // showWorkspaces
                    // function onActiveWindowChanged(value: string): void {
                    function onShowWorkspaces(value: string): void {
                        // console.log(Wayland.pointer.x, Wayland.pointer.y)
                        get_pos.running = true;
                    }
                }
                Connections {
                    target: pnl
                    function onScreenChanged(): void {
                        // 	// console.log(modelData.toString())
                        pos_x = pnl.screen.x;
                        pos_y = pnl.screen.y;
                        screen_w = pnl.screen.width;
                        screen_h = pnl.screen.height;
                    }
                    function onVisibleChanged(): void {
                        // root.
                        // root.get_pos.running = true
                        console.log("updating_pos");
                    // auto_hide.running = true;
                    }
                }
                Timer {
                    id: auto_hide
                    interval: 1000
                    running: false
                    repeat: false
                    onTriggered: {
                        visible = false;
                        // console.log(pnl.screen.x);
                    }
                }

                Process {
                    id: get_pos
                    command: ["hyprctl", "-j", "activewindow"]
                    running: false

                    stdout: StdioCollector {
                        onStreamFinished: {
                            //.pnl.time = this.text;
                            var txt = JSON.parse(text);
                            // console.log("WinIndicator : ");
                            // console.log(txt.at);
                            // console.log("Screen pos ",pnl.myMonitor.x, " x ",pnl.myMonitor.y);
                            // console.log.pnl.pos_y);

                            // console.log(txt.at[0] , (txt.size[0]/2))
                            // console.log(txt.at[0] + (txt.size[0]/2))
                            // console.log.pnl.pnl.screen);
                            //.pnl.ll.v.pn.margins.left = txt.x;
                            // pn.margins.top = txt.y;
                            pnl.window_x = (txt.at[0] - pnl.pos_x) + (txt.size[0] / 2);
                            pnl.window_y = (txt.at[1] - pnl.pos_y) + (txt.size[1] / 2);
                            pnl.show_me = pnl.window_x > pnl.pos_x && pnl.window_x < (pnl.screen_w + pnl.pos_x);
                            // console.log(pnl.window_x , " x ", pnl.pos_x, " x ", pnl.window_x , " x ", (pnl.screen_w ));
                            // console.log(show_me);
                            pnl.visible = false;
                            pnl.show_me = true;
                            auto_hide.restart();
                            if (pnl.show_me) {
                                pnl.visible = show_me;
                            }
                            // console.log("===============");
                            //.pnl.pos_x =  (txt.size[0]/2);
                            //.pnl.pos_y =  (txt.size[1]/2);
                            // if (txt.at[0] >.pnl.pos_x && txt.at[0] < root.pos_x + Math.abs(root) {
                            // 	pnl.visible = true;
                            // }

                        }
                    }
                }

                Item {
                    Rectangle {
                        id: meta
                        // anchors.fill: parent
                        radius: 128
                        visible: true
                        // visible: root.pressed_mod.includes("META")
                        color: root.clr
                        border.width: 4
                        border.color: root.clr
                        border.pixelAligned: true
                        // implicitWidth: cap_text.implicitWidth + 32
                        // implicitWidth: 256

                        implicitHeight: root.square_size
                        implicitWidth: root.square_size
                        Text {
                            // text: "󰁄"
                            text: ""
                            color: root.bg_clr
                            font.pointSize: root.square_size / 2
                            anchors {
                                // fill: parent

                                horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                }
            }
        }
    }
}
