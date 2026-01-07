pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Shapes 1.9
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Wayland
import Quickshell
import ".."

Scope {
    id: root

    property string ctrl_clr: MyColor.pink
    property string meta_clr: MyColor.orange
    property string alt_clr: MyColor.blue
    property string bg_clr: MyColor.bg

    // property string bg_clr: "transparent"
    property var pressed_mod: []
    // property var pressed_mod: ["CTRL", "META", "ALT"]
    property int frame_size: 10
    property string frame_clr: "black"

    Variants {
        model: Quickshell.screens
        PanelWindow {
            // Since the panel's screen is unset, it will be picked by the compositor
            // when the window is created. Most compositors pick the current active monitor.
            id: pn
            required property var modelData
            screen: modelData
            anchors.top: true
            // margins.top: modelData.height * 0.2
            anchors.bottom: true
            anchors.right: true
            anchors.left: true
            // margins.bottom: 128
            // margins.bottom: modelData.height * 0.25
            WlrLayershell.layer: WlrLayer.overlay
            // WlrLayershell.exclusionMode: ExclusionMode.Ignore

            exclusiveZone: 0
            // implicitHeight: 32

            // implicitWidth: 500

            // implicitWidth: (root.square_size + row.spacing) * 3
            // // implicitWidth: row.implicitWidth
            // implicitHeight: root.square_size
            color: "transparent"

            // An empty click mask prevents the window from blocking mouse events.
            mask: Region {}
            visible: true
            FrameCorner {
                size: root.frame_size
                clr: root.frame_clr
                is_left: true
            }
            FrameCorner {
                size: root.frame_size
                clr: root.frame_clr
                is_left: false
            }
            FrameCorner {
                size: root.frame_size
                clr: root.frame_clr
                is_left: true
                is_top: false
            }
            FrameCorner {
                size: root.frame_size
                clr: root.frame_clr
                is_left: false
                is_top: false
            }
        }
    }
}
