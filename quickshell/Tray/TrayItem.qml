import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import Quickshell

Item {
    id: root
    required property SystemTrayItem modelData

    implicitWidth: 20
    implicitHeight: 20
    IconImage {
        // source: modelData.icon
        implicitWidth: 14
        implicitHeight: 14
        mipmap: true
        anchors.centerIn: parent
        // source: root.modelData.icon
        smooth: false
        asynchronous: true
        backer.fillMode: Image.PreserveAspectFit
        source: {
            let icon = modelData?.icon || "";
            if (!icon)
                return "";
            // Process icon path
            if (icon.includes("?path=")) {
                const [name, path] = icon.split("?path=");
                const fileName = name.substring(name.lastIndexOf("/") + 1);
                return `file://${path}/${fileName}`;
            }
            return icon;
        }
        // source: {
        //     let icon = modelData.icon;
        //     if (icon.includes("?path=")) {
        //         const [name, path] = icon.split("?path=");
        //         icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
        //     }
        //     return icon;
        // }
    }
    // Text {
    //     id: name
    //     text: root.modelData.id
    // }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: event => {
            switch (event.button) {
            case Qt.LeftButton:
                modelData.activate();
                break;
            case Qt.RightButton:
                if (modelData.hasMenu) {
                    const window = QsWindow.window;
                    // [TODO] The bellow is kinda hard coded, find a better solution
                    const widgetRect = window.contentItem.mapFromItem(root, 10, root.height - 10, root.width, root.height);
                    menuAnchor.anchor.rect = widgetRect;
                    menuAnchor.open();
                }
                break;
            }
        }
    }
    QsMenuAnchor {
        id: menuAnchor
        menu: modelData.menu
        anchor.window: root.QsWindow.window ?? null
        anchor.adjustment: PopupAdjustment.Flip
    }
    Component.onCompleted: {
        console.log(root.modelData.icon);
    }
}
