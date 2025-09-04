pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Hyprland

// your singletons should always have Singleton as the type
Singleton {
    id: root

    property string dark: "#323449"
    property string darkest: "#212337"
    property string purple: "#7081d0"
    property string violet: "#a48cf2"
    property string green: "#37f499"
    property string blue: "#04d1f9"
    property string yellow: "#f1fc79"
    property string orange: "#f7c67f"
    property string pink: "#f265b5"
    property string red: "#f16c75"

    property string bg: darkest
    property string base: violet
    property string primary: green
    property string secondary: blue
    property string danger: pink

    property bool is_caps_on: false
    property HyprlandWorkspace current_ws
}
