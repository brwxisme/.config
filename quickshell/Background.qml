pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Io
import Quickshell
import Quickshell.Wayland
import Quickshell
import QtQuick

Scope {
    id: root
    property string my_bg: MyColor.darkest
    property int size: 512 + 256
    property list<string> bg_list
    property string sources: "/home/brew/Pictures/Quickshell/"
    property string current_img
    // WlrLayershell.namespace: "quickshell:bg"
    Variants {
        model: Quickshell.screens
        // model: Hyprlan.monitors
        Item {
            required property var modelData

            PanelWindow {
                id: bar_man
                screen: modelData

                // visible: modelData.name == "HDMI-A-1"

                WlrLayershell.layer: WlrLayer.Background
                WlrLayershell.exclusionMode: ExclusionMode.Ignore
                anchors {
                    top: true
                    left: true
                    right: true
                    bottom: true
                }
                color: MyColor.bg

                Rectangle {
                    id: bg_rect
                    implicitWidth: root.size
                    implicitHeight: root.size
                    anchors.centerIn: parent
                    color: "transparent"
                    Image {
                        id: bg_image

                        anchors.centerIn: parent
                        // anchors.fill: parent
                        mipmap: true
                        source: "/home/brew/Pictures/Quickshell/HDMI-A-1/EldritchLogo.png"
                        // source: "/home/brew/Downloads/lorenzo-lanfranconi-jumpstart-1.jpg"
                        fillMode: Image.PreserveAspectFit
                    }
                }
                Connections {
                    target: Globals

                    function onChangeBackground(): void {
                        get_list.running = true;
                    }
                }
                Process {
                    id: get_list
                    command: ["ls", root.sources + bar_man.screen.name]
                    running: true

                    stdout: StdioCollector {
                        onStreamFinished: {
                            console.log(root.sources + modelData.name);
                            root.bg_list = this.text.split("\n");
                            root.bg_list.pop();
                            const current_index = root.bg_list.indexOf(root.current_img);
                            root.bg_list.splice(current_index, 1);
                            // root.bg_list = root.bg_list.filter(item => item !== root.current_img);
                            // root.bg_list.erase(root.current_img);
                            console.log(root.current_img);
                            // console.log(root.bg_list);

                            const randomIndex = Math.floor(Math.random() * bg_list.length);
                            const randomItem = root.bg_list[randomIndex];
                            // console.log(randomIndex, "   xxx   ", randomItem);
                            bg_image.source = root.sources + bar_man.screen.name + "/" + randomItem;
                            root.current_img = randomItem;
                            console.log(root.current_img);
                            // console.log(" XXXXXXXXXXXXXXXXXXXXXXXXXXXX ");
                        }
                    }
                }
            }
        }
    }
}
