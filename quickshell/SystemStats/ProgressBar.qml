import QtQuick
import ".."
import Qt5Compat.GraphicalEffects

Rectangle {
    id: root
    // Stretches to fill all left-over space
    property real max_value
    property real value
    property string clr
    property string border_color: MyColor.base

    implicitHeight: 12
    implicitWidth: 36
    radius: 8
    color: MyColor.purple

    Rectangle {
        color: clr
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }

        implicitWidth: parent.width * (root.value / root.max_value)
        radius: parent.radius
    }
    // Rectangle {
    //     anchors.fill: parent
    //     border.width: 1
    //     border.color: border_color
    //     radius: parent.radius / 2
    //     color: "transparent"
    // }
}
