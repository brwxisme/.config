import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

Item {
    id: root
    property int my_height: 4
    property string clr
    // anchors.fill: parent
    Layout.fillWidth: true

    // Behavior on Layout.preferredWidth {
    //     NumberAnimation {
    //         duration: 250
    //         easing.type: Easing.OutBack
    //     }
    // }
    // Behavior on Layout.fillWidth {
    //     NumberAnimation {
    //         duration: 250
    //         easing.type: Easing.OutBack
    //     }
    // }
    Rectangle {
        id: meta_bar
        color: root.clr

        implicitHeight: root.my_height
        implicitWidth: parent.width
        anchors.bottom: parent.bottom
        radius: 32
    }
    RectangularShadow {
        // visible: false
        anchors.fill: meta_bar
        implicitWidth: root.implicitWidth + 15
        offset.x: 0
        // offset.y: (meta_bar.implicitHeight * -1) + 2
        // blur: 20
        // spread: 4
        spread: 8
        color: root.clr
    }
}
