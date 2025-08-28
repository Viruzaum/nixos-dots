import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import Qt5Compat.GraphicalEffects

MouseArea {
    id: root

    required property SystemTrayItem modelData

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    implicitWidth: 22
    implicitHeight: 22

    onClicked: event => {
        if (event.button === Qt.LeftButton)
            modelData.activate();
        else if (modelData.hasMenu)
            menu.open();
    }

    QsMenuAnchor {
        id: menu

        menu: root.modelData.menu
        anchor.window: this.QsWindow.window
    }

    IconImage {
        id: icon

        source: {
            let icon = root.modelData.icon;
            if (icon.includes("?path=")) {
                const [name, path] = icon.split("?path=");
                icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
            }
            return icon;
        }
        asynchronous: true
        anchors.fill: parent
    }

    ColorOverlay {
        anchors.fill: icon
        source: icon
        color: "#ffdad7"
    }
}
