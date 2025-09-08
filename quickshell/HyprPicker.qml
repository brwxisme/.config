import QtQuick
import Quickshell.Io

Rectangle {
    id: root
    property list<string> command
    property string icon: ""
    property string icon_color: "white"
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
        command: ["hyprpicker", "-a"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                console.log(this.text);
                icon.color = this.text.replace(/(\r\n|\n|\r)/gm, "");
            }
        }
    }
}
