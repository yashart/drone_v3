import QtQuick 2.4

AddTracksForm {
    addTracksArea.onEntered: {
        opacity = 1
    }
    addTracksArea.onExited: {
        opacity = 0.75
    }
}
