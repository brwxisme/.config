import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import ".."

Scope {
    id: root

    property Item base
    property bool visible: false
    property string text
    property Rectangle addition

    // onShouldShowOsdChanged: {
    //     hideTimer.restart();
    // }

    // MyColor.is_caps_onChanged: {
    //     shouldShowOsd = true;
    //     hideTimer.restart();
    // }

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.visible = false
    }

    // The OSD window will be created and destroyed based on shouldShowOsd.
    // PanelWindow.visible could be set instead of using a loader, but using
    // a loader will reduce the memory overhead when the window isn't open.
    LazyLoader {
        active: root.visible

        PanelWindow {
            id: pw
            anchors.top: base.top
            anchors.right: parent
            exclusiveZone: 0
            WlrLayershell.layer: WlrLayer.Overlay

            color: "transparent"
            // width: text_.implicitWidth
            // height: text_.implicitHeight

            // An empty click mask prevents the window from blocking mouse events.
            mask: Region {}

            Rectangle {
                id: rect
                radius: height / 8
                color: MyColor.bg
                border.width: 2
                border.color: is_caps_on ? MyColor.pink : MyColor.base
                border.pixelAligned: true
                // width: text_.implicitWidth
                width: text_.implicitWidth + 32
                height: text_.implicitHeight
                Text {
                    id: text_
                    text: root.text
                    color: is_caps_on ? MyColor.pink : MyColor.base
                    font.pointSize: 8
                    padding: 8
                    // width: 1000
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }

    function close() {
        visible = false;
    }
}
