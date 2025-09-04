import QtQuick
import "Workspace" as WS

Item {
    id: ws_left
    implicitWidth: 256 + 32
    height: 24
    anchors.horizontalCenter: parent.horizontalCenter
    Rectangle {
        id: recta

        anchors.top: parent.top
        // anchors.topMargin: -4

        implicitWidth: 256
        implicitHeight: 20
        color: my_bg
        // anchors.horizontalCenter: parent.horizontalCenter
        // bottomLeftRadius: 32
        // bottomRightRadius: 32
        radius: 32
        WS.Workspaces {
            scrn: modelData
            implicitHeight: 32
        }
        border.color: MyColor.base
        border.width: 1
    }
}
