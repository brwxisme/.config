import QtQuick
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import Quickshell
import Qt5Compat.GraphicalEffects
import ".."

Rectangle {
    // width: 228
    // height: parent.height
    implicitHeight: 20
    implicitWidth: row.implicitWidth

    // color: "white"
    color: "transparent"
    anchors {
        //     right: parent.right
        verticalCenter: parent.verticalCenter
        //     rightMargin: 12
    }

    RowLayout {
        id: row
        height: parent.height
        anchors.right: parent.right
        spacing: 8
        Layout.alignment: Qt.AlignRight
        Layout.fillWidth: false
        // layoutDirection: Qt.RightToLeft

        LineProgressBar {
            id: memory_stats
            text: ""
            value: CurrentStats.mem_used_gb
            max_value: CurrentStats.mem_total_gb
            clr: MyColor.pink
        }
        LineProgressBar {
            id: memory_stats_2
            text: ""
            // text: "" + `${(CurrentStats.cpuPerc * 100).toFixed(2)}`
            value: CurrentStats.cpuPerc
            max_value: 1
            clr: MyColor.yellow
            tooltip_text: `${(CurrentStats.cpuPerc * 100).toFixed(2)}` + "%"
        }
        // LineProgressBar {
        //     id: volume_stat
        //     text: ""
        //     // text: "" + `${(CurrentStats.cpuPerc * 100).toFixed(2)}`
        //     value: (Pipewire.defaultAudioSink?.audio.volume ?? 0)
        //     max_value: 1
        //     clr: MyColor.blue
        //     tooltip_text: `${((Pipewire.defaultAudioSink?.audio.volume ?? 0) * 100).toFixed(0)}` + "%"
        // }
        // ProgressBar {
        //     id: memory_stats_2
        //     value: CurrentStats.mem_used_gb
        //     max_value: CurrentStats.mem_total_gb
        //     clr: MyColor.yellow
        // }
    }
}
