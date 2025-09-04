import QtQuick
import Quickshell.Io

Rectangle {
    id: root
    property list<string> command
    property string icon: "x"
    property string icon_color
    color: "transparent"
    implicitWidth: icon.implicitWidth + 8
    implicitHeight: 16
    anchors.verticalCenter: parent.verticalCenter
    Text {
        id: icon
        text: root.icon
        color: root.icon_color
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            wlSession.running = true;
        }
    }
    Process {
        id: wlSession
        command: root.command
        running: false
    }
}
