import QtQuick
import Quickshell
import ".."

Scope {
    id: root

    property Item base
    property bool visible: false
    property string text
    property Rectangle addition

    PanelWindow {
        id: toplevel

        exclusiveZone: 0
        // anchors {
        //     bottom: true
        //     left: true
        //     right: true
        // }
        color: "transparent"

        PopupWindow {
            // anchor.window: toplevel
            // anchor.rect.x: parentWindow.width / 2 - width / 2
            anchor.item: base
            anchor.rect.y: base.height + 8
            // anchor.rect.height: rect_.height + 32
            // anchor.rect.x: 0
            // width: 128
            // height: rect_.implicitHeight

            visible: root.visible
            color: "transparent"
            Rectangle {
                id: rect_
                radius: height / 8
                color: MyColor.bg
                border.width: 2
                border.color: MyColor.base
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
