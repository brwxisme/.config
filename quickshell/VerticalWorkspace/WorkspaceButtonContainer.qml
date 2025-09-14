import QtQuick
import Quickshell.Hyprland

import ".."

Rectangle {
    id: root
    // anchors.fill: parent
    property var scrn
    property int ws_total: 5
    property color my_base: MyColor.base
    property int starting_idx: {
        scrn.name == "DP-2" ? 1 : 6;
    }
    // color: MyColor.pink
    color: "transparent"
    signal workspaceAdded(workspace: HyprlandWorkspace)
    anchors {
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
    }
    Column {
        spacing: 4
        // anchors.fill: parent
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
        // Text {
        //     color: "#FFF"
        //     text: "etnfre " + scrn.name
        // }

        Repeater {
            model: ws_total
            // model: 5
            VerticalWorkspaceButton {
                id: ws_item
                base_size: 16

                my_base: root.my_base
                ws_index: index + starting_idx
                workspace: null
                exists: workspace != null
                active: (workspace?.active) ?? false
                current: (workspace?.active && workspace?.focused) ?? false

                Connections {
                    target: root

                    function onWorkspaceAdded(workspace: HyprlandWorkspace) {
                        if (workspace.id == ws_item.ws_index) {
                            ws_item.workspace = workspace;
                        }
                    }
                }
            }
        }
    }
    Connections {
        target: Hyprland.workspaces

        function onObjectInsertedPost(workspace) {
            root.workspaceAdded(workspace);
        }
    }

    Component.onCompleted: {
        Hyprland.workspaces.values.forEach(workspace => {
            root.workspaceAdded(workspace);
        });
    }
}
