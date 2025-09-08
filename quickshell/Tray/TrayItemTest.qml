import QtQuick
import QtQuick.Controls as C
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

Item {
    id: root
    required property SystemTrayItem modelData

    implicitWidth: 20
    implicitHeight: 20

    IconImage {
        implicitWidth: 14
        implicitHeight: 14
        mipmap: true
        anchors.centerIn: parent
        smooth: false
        asynchronous: true
        backer.fillMode: Image.PreserveAspectFit
        source: {
            let icon = modelData?.icon || "";
            if (!icon)
                return "";
            if (icon.includes("?path=")) {
                const [name, path] = icon.split("?path=");
                const fileName = name.substring(name.lastIndexOf("/") + 1);
                return `file://${path}/${fileName}`;
            }
            return icon;
        }
    }

    // Right-click opens our custom, stylable popup instead of the native one
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: event => {
            if (event.button === Qt.LeftButton) {
                modelData.activate();
            } else if (event.button === Qt.RightButton) {
                // position near the icon
                const p = root.mapToItem(null, 0, root.height);
                customMenu.x = p.x;
                customMenu.y = p.y - 500;
                customMenu.open();
            }
        }
    }

    // Expose the tray's DBus menu entries to QML
    QsMenuOpener {
        id: opener
        menu: modelData.menu    // QsMenuHandle from the tray item
    }

    // Main popup – fully styleable
    C.Popup {
        id: customMenu
        modal: true
        focus: true
        implicitHeight: 512
        padding: 4
        background: Rectangle {
            color: "#222831"    // <-- your background color
            radius: 8
        }

        contentItem: Column {
            spacing: 2
            Repeater {
                model: opener.children   // ObjectModel<QsMenuEntry>
                delegate: Loader {
                    // Each modelData is a QsMenuEntry
                    property var entry: modelData
                    sourceComponent: entry && entry.isSeparator ? sepDelegate : itemDelegate
                }
            }
        }

        // Separator delegate
        Component {
            id: sepDelegate
            Rectangle {
                width: customMenu.implicitWidth
                height: 1
                color: "#3a3f44"
                opacity: 1
            }
        }

        // Item delegate
        Component {
            id: itemDelegate
            Item {
                width: 220
                height: 28
                enabled: entry.enabled

                // hover background
                Rectangle {
                    anchors.fill: parent
                    radius: 6
                    visible: mouse.hovered
                    color: "#2E3440"
                }

                Row {
                    anchors.fill: parent
                    anchors.margins: 8
                    spacing: 8

                    Image {
                        source: entry.icon
                        visible: !!entry.icon
                        width: 16
                        height: 16
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        text: entry.text
                        color: "white"
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        // Layout.fillWidth: true
                    }

                    // check/radio indicator (simple)
                    Text {
                        text: entry.buttonType === QsMenuButtonType.CheckBox && entry.checkState !== Qt.Unchecked ? "✓" : (entry.buttonType === QsMenuButtonType.RadioButton && entry.checkState === Qt.Checked ? "●" : "")
                        color: "white"
                        visible: text.length > 0
                    }

                    // submenu arrow
                    Text {
                        text: entry.hasChildren ? "▶" : ""
                        color: "white"
                        visible: entry.hasChildren
                    }
                }

                MouseArea {
                    id: mouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        if (entry.hasChildren) {
                            submenu.entry = entry;
                            const gp = parent.mapToItem(null, parent.width, 0);
                            submenu.x = gp.x;
                            submenu.y = customMenu.y + parent.y;
                            submenu.open();
                        } else {
                            // Emit the entry's triggered signal to activate it
                            entry.triggered();   // Quickshell connects this to DBusMenu activation
                            customMenu.close();
                        }
                    }
                }
            }
        }
    }

    // Simple submenu popup (same styling)
    C.Popup {
        id: submenu
        modal: false
        focus: true
        property var entry // QsMenuEntry with children

        padding: 4
        background: Rectangle {
            color: "#222831"
            radius: 8
        }

        // opener for submenu
        QsMenuOpener {
            id: submenuOpener
            menu: submenu.entry
        }

        contentItem: Column {
            spacing: 2
            Repeater {
                model: submenuOpener.children
                delegate: Loader {
                    property var entry: modelData
                    sourceComponent: entry && entry.isSeparator ? sepDelegate : itemDelegate
                }
            }
        }
    }
}
