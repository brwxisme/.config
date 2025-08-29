import Quickshell
import QtQuick.Effects
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    property real my_width: 64
    property real my_height: 64
    width: my_width
    height: my_height
    Rectangle {
        id: to_mask
        width: root.my_width
        height: root.my_height
        // color: MyColor.green
        color: "pink"
        // anchors.top: parent
        visible: false
        // radius: width
        GridLayout {
            id: grid
            columns: 2
            anchors.fill: parent
            rowSpacing: 1
            columnSpacing: 1
            Repeater {
                model: 4
                Rectangle {
                    // color: "red"
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    // visible: index === 3
                    color: index == 3 ? "red" : "transparent"
                    Text {
                        text: index
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }
    MultiEffect {
        source: to_mask
        anchors.fill: to_mask
        // maskEnabled: true
        maskSource: the_mask
        maskInverted: true
        maskThresholdMin: 0.9
    }

    Item {
        // id: mask
        id: the_mask
        layer.enabled: true

        width: to_mask.width
        height: to_mask.height
        visible: false

        Rectangle {
            id: mask_rect
            // width: 32
            // anchors.bottom: parent.bottom
            // height: 32
            anchors.fill: parent
            anchors.centerIn: to_mask
            color: MyColor.pink
            radius: width / 2
        }
        MultiEffect {
            source: mask_rect
            anchors.fill: mask_rect
            // blurEnabled: true
            blur: 0.5
            blurMax: 8
        }
    }
}
