import QtQuick 2.4

PopupPointsForm {

    popupPointsArea.onEntered: {
        opacity = 1
    }
    popupPointsArea.onExited: {
        opacity = 0.75
    }
}
