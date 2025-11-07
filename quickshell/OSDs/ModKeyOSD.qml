pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Io
import Quickshell.Wayland
import Quickshell
import ".."

Scope {
    id: root

    property string ctrl_clr: MyColor.pink
    property string meta_clr: MyColor.yellow
    property string alt_clr: MyColor.blue
    property string bg_clr: MyColor.bg

    // property string bg_clr: "transparent"
    property var pressed_mod: []
    // property var pressed_mod: ["CTRL", "META", "ALT"]
    property int square_size: 96
    property int icon_size: 48

    Connections {
        target: Globals

        function onModReleased(value: string): void {
            pressed_mod = pressed_mod.filter(k => k !== value);
            root.pressed_modChanged();
        // console.log(root.pressed_mod, " CUTTED ");
        }
        function onModPressed(value: string): void {
            root.pressed_mod.push(value);
            // console.log(root.pressed_mod, " INSERTED ");
            root.pressed_modChanged();
        }
    }
    LazyLoader {
        id: ll
        // active: true
        active: root.pressed_mod.length != 0

        Variants {
            model: Quickshell.screens
            PanelWindow {
                // Since the panel's screen is unset, it will be picked by the compositor
                // when the window is created. Most compositors pick the current active monitor.
                id: pn
                required property var modelData
                screen: modelData
                // anchors.top: true
                // margins.top: modelData.height * 0.2
                anchors.bottom: true
                // margins.bottom: 128
                margins.bottom: modelData.height * 0.25
                WlrLayershell.layer: WlrLayer.Overlay

                exclusiveZone: 0

                implicitWidth: (root.square_size + row.spacing) * 3
                // implicitWidth: row.implicitWidth
                implicitHeight: root.square_size
                color: "transparent"

                // An empty click mask prevents the window from blocking mouse events.
                mask: Region {}

                Row {
                    id: row
                    spacing: 8
                    // anchors.fill: parent
                    // implicitHeight: rect.implicitHeight
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle {
                        id: ctrl
                        // anchors.fill: parent
                        radius: 24
                        visible: root.pressed_mod.includes("CTRL")
                        // color: MyColor.bg
                        color: root.bg_clr
                        border.width: 4
                        border.color: root.ctrl_clr
                        border.pixelAligned: true
                        // implicitWidth: cap_text.implicitWidth + 32
                        // implicitWidth: 256

                        implicitHeight: root.square_size
                        implicitWidth: root.square_size
                        Text {
                            id: cap_text
                            // text: "󰘴"
                            text: ""
                            color: root.ctrl_clr
                            font.pointSize: 48
                            anchors {
                                horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                    Rectangle {
                        id: meta
                        // anchors.fill: parent
                        radius: 24
                        // visible: false
                        visible: root.pressed_mod.includes("META")
                        color: root.bg_clr
                        border.width: 4
                        border.color: root.meta_clr
                        border.pixelAligned: true
                        // implicitWidth: cap_text.implicitWidth + 32
                        // implicitWidth: 256

                        implicitHeight: root.square_size
                        implicitWidth: root.square_size
                        Text {
                            // text: ""
                            text: ""
                            color: root.meta_clr
                            font.pointSize: 48
                            anchors {
                                // fill: parent

                                horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                    Rectangle {
                        id: alt
                        // anchors.fill: parent
                        radius: 24
                        // visible: false
                        visible: root.pressed_mod.includes("ALT")
                        color: root.bg_clr
                        border.width: 4
                        border.color: root.alt_clr
                        border.pixelAligned: true
                        // implicitWidth: cap_text.implicitWidth + 32
                        // implicitWidth: 256

                        implicitHeight: root.square_size
                        implicitWidth: root.square_size
                        Text {
                            // text: "󰘵"
                            text: ""
                            color: root.alt_clr
                            font.pointSize: 48
                            // horizontalAlignment: Text.AlignHCenter // Centers the text horizontally
                            // verticalAlignment: Text.AlignVCenter // Centers the text vertically
                            anchors {
                                horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                }
            }
        }
    }
}
