pragma ComponentBehavior: Bound

import "components"
import "root:/widgets"
import Quickshell
import Quickshell.Wayland
import QtQuick

Scope {

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            property var modelData
            screen: modelData

            WlrLayershell.namespace: "quickshell:bar"
            implicitWidth: 40 + 23
            exclusiveZone: 40 
            mask: Region {
                item: barContent
            }
            color: "transparent"

            anchors {
                top: true
                left: true
                bottom: true
            }

            Item {
                id: barContent
                anchors {
                    right: undefined
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                implicitWidth: 40
                width: 40

                Rectangle {
                    id: barBackground
                    anchors {
                        fill: parent
                        margins: 0
                    }
                    color: "#231919"
                }

                Text {
                    id: osIcon
                    anchors {
                        top: parent.top
                        horizontalCenter: parent.horizontalCenter
                    }
                    topPadding: 20
                    color: "#ffdad7"

                    text: "󱄅"
                }

                Workspaces {
                    id: workspaces
                    screen: root.screen

                    anchors {
                        top: osIcon.bottom
                        horizontalCenter: parent.horizontalCenter
                        topMargin: 20
                    }
                }

                Clock {
                    anchors.centerIn: parent
                    font.family: "Tsukimi Rounded"
                    font.bold: true
                    color: "#ffdad7"
                }

                Rectangle {
                    anchors {
                        centerIn: parent
                        margins: 0
                    }

                    color: "#271d1d"
                    height: 2
                    width: 23
                    
                    radius: 3
                }

                Tray {
                    id: tray

                    anchors {
                        bottom: parent.bottom
                        horizontalCenter: parent.horizontalCenter
                        bottomMargin: 20
                    }
                }
            }

            Item {
                id: roundDecorators
                anchors {
                    top: parent.top
                    // left: parent.right
                    // bottom: parent.bottom
                }
                x: 17
                width: 23
                height: parent.height

                Item {
                    implicitWidth: 23
                    height: parent.height

                    RoundCorner {
                        id: bottomCorner
                        anchors {
                            left: parent.right
                            // right: undefined
                            bottom: parent.bottom
                            // top: parent.bottom
                            // top: undefined
                        }

                        size: 23
                        color: barBackground.color
                        // color: "#FFFFFF"

                        corner: RoundCorner.CornerEnum.BottomLeft
                    }

                    RoundCorner {
                        id: topCorner
                        anchors {
                            left: parent.right
                            // right: parent.right
                            top: parent.top
                        }

                        size: 23
                        color: barBackground.color
                        // color: "#FFFFFF"

                        corner: RoundCorner.CornerEnum.TopLeft
                    }
                }
            }
        }
    }
}
