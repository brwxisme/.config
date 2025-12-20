import QtQuick
import Quickshell.Io

Rectangle {
    color: "transparent"
    implicitWidth: icon.implicitWidth + 8
    implicitHeight: 16
    anchors.verticalCenter: parent.verticalCenter
    Text {
        id: icon
        text: ""
        color: MyColor.yellow
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            Globals.showCrosshair = !Globals.showCrosshair;
        }
    }
}
