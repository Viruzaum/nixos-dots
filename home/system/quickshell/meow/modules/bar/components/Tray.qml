import Quickshell.Services.SystemTray
import QtQuick

Item {
    id: root

    readonly property Repeater items: items

    clip: true
    visible: width > 0 && height > 0

    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    Column {
        id: layout

        spacing: 10

        Repeater {
            id: items

            model: SystemTray.items

            TrayItem {}
        }
    }
}
