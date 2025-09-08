import Quickshell
import QtQuick.Layouts
import QtQuick.Window
import "../CustomPopUp/" as Pop
import ".."

Rectangle {
    id: root
    // Stretches to fill all left-over space

    property real max_value
    property real value
    property string clr: MyColor.pink
    property string text: " "
    property string border_color: MyColor.base
    property string tooltip_text

    implicitHeight: 10
    // implicitWidth: 64
    implicitWidth: 64
    color: "transparent"
    // color: "pink"

    // Pop.Base {
    Pop.Test {
        id: customTooltip
        visible: false
        text: {
            if (root.tooltip_text == "") {
                return root.value + " / " + root.max_value;
            } else {
                return tooltip_text;
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 4
        Text {
            id: name
            text: root.text
            color: clr
            font.pointSize: parent.height
            anchors {
                verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            color: MyColor.purple

            implicitHeight: 4
            // implicitWidth: 28
            Layout.fillWidth: true
            radius: 2
            anchors {
                verticalCenter: parent.verticalCenter
            }
            Rectangle {
                radius: 2
                implicitHeight: parent.implicitHeight
                color: clr

                // implicitWidth: parent.width / 2
                implicitWidth: parent.width * (root.value / root.max_value)
                anchors {
                    verticalCenter: parent.verticalCenter
                }
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        // When hovering, configure and open the custom popup
        onClicked: {
            customTooltip.visible = true;
            customTooltip.base = root;
        }
        onEntered: {
            // customTooltip.sourceItem = parent;
            // customTooltip.text = "Custom tooltip outside clipped parent.";
            // // customTooltip.open();
            // console.log(customTooltip.text);
            customTooltip.visible = true;
            customTooltip.base = root;
            // console.log("eee");
        }

        // When leaving, close the popup
        onExited: {
            customTooltip.close();
        }
    }
    // ShellRoot.
}
