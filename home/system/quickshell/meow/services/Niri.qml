// Kind thanks to https://github.com/MapoMagpie/nixos-flakes/blob/main/home/ui/quickshell/config/Data/Niri.qml
// This file was taken from there and further modified.

pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property var workspaces: []
    property var currentWorkspace: -1
    property var overviewOpen: false

    Process {
        id: niriProcess
        command: ["niri", "msg", "-j", "event-stream"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                try {
                    const event = JSON.parse(data);
                    if (event.WorkspaceActivated) {
                        const workspaceId = event.WorkspaceActivated.id;
                        if (workspaceId) {
                            root.currentWorkspace = workspaceId;
                        }
                    } else if (event.WorkspacesChanged) {
                        root.workspaces = event.WorkspacesChanged.workspaces;
                        root.workspaces = root.workspaces.sort((a, b) => a.idx - b.idx);
                        root.currentWorkspace = root.workspaces.findIndex(w => w.is_focused);
                    } else if (event.OverviewOpenedOrClosed) {
                        root.overviewOpen = event.OverviewOpenedOrClosed.is_open;
                    }
                } catch (e) {
                    console.error("Errors parsing niri event:", e);
                }
            }
        }

        // onExited: {
        //     if (exitCode != 0 && !root.isDestroying) {
        //         Qt.calllater(() => running = true);
        //     }
        // }
    }

    function updateWorkspaceFocus(focusedWorkspaceId) {
        for (let i = 0; i < root.workspaces.count; i++) {
            const workspace = root.workspaces.get(i);
            const wasFocused = workspace.isFocused;
            const isFocused = workspace.id === focusedWorkspaceId;
            const isActive = workspace.id === focusedWorkspaceId;

            if (wasFocused != isFocused) {
                root.workspaces.setProperty(i, "isFocused", isFocused);
                root.workspaces.setProperty(i, "isActive", isActive);
            }
        }
    }
}
