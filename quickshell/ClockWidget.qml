import QtQuick
import Quickshell.Io

Text {
    id: root

    font.family: "Fira Code"
    font.weight: 600
    // width: 320
    // height: 8
    color: MyColor.primary
    y: height / 2
    // verticalCenter: parent.verticalCenter
    // topMargin: 32
    // horizontalCenter: parent.horizontalCenter
    anchors {}
    text: root.time
    focus: true
    Process {
        id: dateProc
        // command: ["date", "+%A %H:%M"]
        command: ["date", "+%H:%M"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.text = this.text
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}
