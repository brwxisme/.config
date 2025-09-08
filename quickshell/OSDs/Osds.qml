import Quickshell
import Quickshell.Io
import QtQuick.Window
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import ".."

Scope {
    id: osd
    property string is_caps_on

    TextCapsOSD {
        id: caposd
    }
    NewAudioOSD {}
    Process {
        id: checkCaps
        // command: ["cat", "/sys/class/leds/input*::capslock/brightness"]
        command: ["sh", "-c", "cat /sys/class/leds/input*::capslock/brightness | head -n 1"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                caposd.is_caps_on = this.text.includes("1");
            }
        }
    }
    GlobalShortcut {
        appid: "quickshell"
        name: "my-keybind"
        onReleased: {
            checkCaps.running = true;
        }
    }
}
