import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import "../Components/"

Item {
    id: root
    property int my_height: 4
    property string clr
    // anchors.fill: parent
    // Layout.fillWidth: true
    width: 256
    Layout.fillHeight: true

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
    CurlyBoxHorizontal {
        totalWidth: parent.width
        totalHeight: parent.height
        bgColor: root.clr
        borderColor: bgColor
    }
}
