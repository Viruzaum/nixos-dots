import "root:/services"
import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: win

        required property ShellScreen modelData
        property bool overviewOpen: Niri.overviewOpen

        screen: modelData
        WlrLayershell.namespace: "wallpaper"
        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Background
        color: "transparent"

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        Image {
            id: wallpaperImage
            anchors.fill: parent
            source: "/home/viruz/pictures/wallpapers/1.jpg"
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            cache: false
            visible: !win.overviewOpen
        }

        MultiEffect {
            source: wallpaperImage
            anchors.fill: wallpaperImage
            blurEnabled: true
            visible: win.overviewOpen
            blur: 0.5
        }
    }
}
