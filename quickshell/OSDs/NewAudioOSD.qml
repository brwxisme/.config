import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

import Quickshell.Wayland
import ".."

Scope {
    id: root

    // Bind the pipewire node so its volume will be tracked
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio

        function onVolumeChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }
    }

    property bool shouldShowOsd: false

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

            // anchors.bottom: true
            // margins.bottom: 8
            // exclusiveZone: 0

            implicitWidth: 256
            implicitHeight: 32
            color: "transparent"
            WlrLayershell.layer: WlrLayer.Overlay

            // An empty click mask prevents the window from blocking mouse events.
            mask: Region {}

            Rectangle {
                anchors.fill: parent
                // topLeftRadius: 8
                // topRightRadius: 8
                radius: 24
                color: MyColor.bg
                border.width: 1
                border.color: MyColor.base
                border.pixelAligned: true

                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: 32
                        rightMargin: 32
                    }

                    Text {
                        text: ""
                        color: MyColor.primary
                        font.pointSize: 12
                        anchors {
                            verticalCenter: parent.verticalCenter
                        }
                    }
                    Rectangle {
                        // Stretches to fill all left-over space
                        Layout.fillWidth: true

                        implicitHeight: 4
                        radius: 20
                        color: MyColor.base

                        Rectangle {
                            color: MyColor.green
                            anchors {
                                left: parent.left
                                top: parent.top
                                bottom: parent.bottom
                            }

                            implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
                            radius: parent.radius
                            Behavior on implicitWidth {
                                NumberAnimation {
                                    duration: 125
                                    easing.type: Easing.OutBack
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
