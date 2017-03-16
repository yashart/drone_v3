import QtQuick 2.4

InstrumentsForm {
    leftMenuButton.onClicked: {
        leftTabMenu.visible = true
        rulerPopup.visible = false
    }
    rulerButton.onClicked: {
        rulerPopup.visible = true
    }
    pointsButton.onClicked: {
        rulerPopup.visible = false
    }
    removeButton.onClicked: {
        rulerPopup.visible = false
    }
    mouseButton.onClicked: {
        rulerPopup.visible = false
    }
    angleButton.onClicked: {
        rulerPopup.visible = false
    }
    savePointsButton.onClicked: {
        rulerPopup.visible = false
    }
}
