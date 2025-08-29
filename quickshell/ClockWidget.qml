import QtQuick

Rectangle {
    id: clockWidget
    property var screen: (typeof modelData !== 'undefined' ? modelData : null)
    property var showTooltip: false
    width: textItem.paintedWidth
    height: textItem.paintedHeight
    color: "transparent"

    Text {
        id: textItem
        text: "18:18"
        font.family: Theme.fontFamily
        font.weight: Font.Bold
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.textPrimary
        anchors.centerIn: parent
    }

    MouseArea {
        id: clockMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: showTooltip = true
        onExited: showTooltip = false
        cursorShape: Qt.PointingHandCursor
        // onClicked: function () {
        //     calendar.visible = !calendar.visible;
        // }
    }

    // Calendar {
    //     id: calendar
    //     screen: clockWidget.screen
    //     visible: false
    // }
    //
    // StyledTooltip {
    //     id: dateTooltip
    //     text: Time.dateString
    //     tooltipVisible: showTooltip && !calendar.visible
    //     targetItem: clockWidget
    //     delay: 200
    // }
}
