import QtQuick
import Quickshell
import Quickshell.Io
import "../../../services"

Rectangle {
    id: root

    required property ShellScreen screen
    property var workspaces: Niri.workspaces
    property var currentWorkspace: Niri.currentWorkspace

    signal workspaceChanged(int workspaceId, color accentColor)
    function onWorkspaceAdded(workspace: var) {
        root.workspaces.push(workspace);
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton
        onWheel: event => {
            proc_focus_workspace.direction = (event.angleDelta.y > 0) ? "up" : "down";
            proc_focus_workspace.running = true;
        }

        Process {
            id: proc_focus_workspace
            running: false
            property string direction: "down"
            command: ["niri", "msg", "action", `focus-workspace-${direction}`]
        }
    }

    color: "#423736"
    width: 23
    height: workspaceColumn.implicitHeight + 25

    radius: width / 2


    Column {
        id: workspaceColumn
        anchors.centerIn: parent

        ListView {
            id: list
            model: root.workspaces.filter(w => w.output === root.screen.name)
            implicitHeight: contentHeight
            implicitWidth: contentItem.childrenRect.width
            spacing: 6

            
            delegate: Rectangle {
                id: workspacePill

                required property string id
                required property string idx
                required property string output
                property bool isActive: (id == root.currentWorkspace)

                width: 15
                height: (isActive ? 30 : 15)
                radius: width / 2

                color: {
                    if (isActive) {
                        return "#e2c28c";
                    }
                    return "#ffb3af";
                }

                Behavior on height {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 300
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    acceptedButtons: Qt.LeftButton
                    onClicked: {
                        switchProcess.command = ["niri", "msg", "action", "focus-workspace", parent.idx.toString()];
                        switchProcess.running = true;
                    }
                }
            }
        }
    }

    Process {
        id: switchProcess
        running: false
        onExited: {
            running: false
            if (exitCode != 0) {
                console.log("Failed to switch workspace:", exitCode);
            }
        }
    }

    Component.onCompleted: {
        Niri.workspaces.forEach(workspace => {
            root.workspaceAdded(workspace);
        })
    }
}
