import QtQuick
import Quickshell.Services.SystemTray

Row {
    id: rows
    leftPadding: 8
    // TrayItemA {}
    Repeater {
        id: items
        model: SystemTray.items
        TrayItem {}
    }
    // Component.onCompleted: {
    //     console.log("Hello");
    //     SystemTray.items.values.forEach(systray => {
    //         console.log(systray.id + ", " + systray.icon);
    //     });
    // }
}
