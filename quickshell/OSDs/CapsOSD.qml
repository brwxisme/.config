import QtQuick
import Quickshell.Wayland
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import ".."

Scope {
    id: root

    property bool is_caps_on: false
    property bool shouldShowOsd: false

    // onShouldShowOsdChanged: {
    //     hideTimer.restart();
    // }
    onIs_caps_onChanged: {
        shouldShowOsd = true;
        hideTimer.restart();
    }

    // MyColor.is_caps_onChanged: {
    //     shouldShowOsd = true;
    //     hideTimer.restart();
    // }

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }

    // The OSD window will be created and destroyed based on shouldShowOsd.
    // PanelWindow.visible could be set instead of using a loader, but using
    // a loader will reduce the memory overhead when the window isn't open.
    LazyLoader {
        active: root.shouldShowOsd

        PanelWindow {
            // Since the panel's screen is unset, it will be picked by the compositor
            // when the window is created. Most compositors pick the current active monitor.

            anchors.bottom: true
            margins.bottom: screen.height / 5
            WlrLayershell.layer: WlrLayer.Overlay

            exclusiveZone: 0

            implicitWidth: 150
            implicitHeight: 150
            color: "transparent"

            // An empty click mask prevents the window from blocking mouse events.
            mask: Region {}

            Rectangle {
                anchors.fill: parent
                radius: height / 8
                color: MyColor.bg
                border.width: 2
                border.color: is_caps_on ? MyColor.pink : MyColor.base
                border.pixelAligned: true

                Text {
                    text: ""
                    color: is_caps_on ? MyColor.pink : MyColor.base
                    font.pointSize: 64
                    y: 8
                    anchors {
                        bottomMargin: 0
                        horizontalCenter: parent.horizontalCenter
                        // verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
}
