import QtQuick
import Quickshell.Hyprland
import ".."

Rectangle {
    anchors {
        verticalCenter: parent.verticalCenter
    }

    property int ws_index: index
    property HyprlandWorkspace workspace: null
    property bool exists: workspace != null
    property bool active: workspace?.active ?? false
    property bool current: (workspace?.active && workspace?.focused) ?? false

    property color my_base: MyColor.base

    property string my_color: {
        if (current) {
            return MyColor.primary;
        } else if (active) {
            return MyColor.secondary;
        } else if (exists) {
            return my_base;
        } else {
            return "transparent";
        }
    }

    width: {
        if (current || active) {
            return 48;
        } else {
            return 24;
        }
    }
    height: 10
    radius: 8
    border.width: 1
    border.color: {
        if (!exists) {
            my_base;
        } else {
            my_color;
        }
    }
    // color: modelData.active ? MyColor.green : MyColor.purple
    // color: exists ? MyColor.purle : "transparent"
    // color: active ? MyColor.green : MyColor.purple
    color: my_color

    Text {
        id: name
        // text: ws_index + " x " + current + active
        // text: ws_index
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch(`workspace ${ws_index}`)
    }

    Behavior on width {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutBack
        }
    }
    Behavior on color {
        ColorAnimation {
            duration: 250
            easing.type: Easing.Linear
        }
    }
    Behavior on border.color {
        ColorAnimation {
            duration: 250
            easing.type: Easing.Linear
        }
    }
}
