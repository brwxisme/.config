pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
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
        active: true
        // active: root.pressed_mod.length != 0

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
                anchors.right: true
                anchors.left: true
                // margins.bottom: 128
                // margins.bottom: modelData.height * 0.25
                WlrLayershell.layer: WlrLayer.Overlay

                exclusiveZone: 0
                implicitHeight: 32

                // implicitWidth: 500

                // implicitWidth: (root.square_size + row.spacing) * 3
                // // implicitWidth: row.implicitWidth
                // implicitHeight: root.square_size
                color: "transparent"

                // An empty click mask prevents the window from blocking mouse events.
                mask: Region {}
                // visible: root.pressed_mod.includes("META")
                RowLayout {
                    visible: false

                    // anchors.fill: parent
                    // Layout.fillWidth: parent
                    spacing: 32
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }
                    // anchors.bottomMargin: 0
                    // anchors.bottom: parent.bottom
                    ModBar {
                        clr: root.meta_clr
                        visible: root.pressed_mod.includes("META")
                    }
                    ModBar {
                        clr: root.ctrl_clr
                        visible: root.pressed_mod.includes("CTRL")
                    }
                    ModBar {
                        clr: root.alt_clr
                        visible: root.pressed_mod.includes("ALT")
                    }
                }
                RowLayout {

                    // width: 512
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        // centerIn: parent
                        // left: parent.left
                        // right: parent.right
                        bottom: parent.bottom
                    }
                    height: 22
                    spacing: -16
                    // spacing: 0

                    ModBarCurly {
                        clr: root.ctrl_clr
                        visible: root.pressed_mod.includes("CTRL")
                        Text {
                            text: ""
                            color: MyColor.bg
                            font.weight: 600
                            font.pointSize: 14
                            anchors.centerIn: parent
                        }
                    }
                    ModBarCurly {
                        clr: root.meta_clr
                        visible: root.pressed_mod.includes("META")
                        Text {
                            text: ""
                            color: MyColor.bg
                            font.weight: 600
                            font.pointSize: 14
                            anchors.centerIn: parent
                        }
                    }
                    ModBarCurly {
                        clr: root.alt_clr
                        visible: root.pressed_mod.includes("ALT")
                        Text {
                            text: ""
                            color: MyColor.bg
                            font.weight: 600
                            font.pointSize: 14
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
    }
}
