import QtQuick 2.4

InstrumentsImageForm {
    hideButtonImage.onClicked: {
        if (imagePage.photoInformation.visible == true) {
            hideButtonImage.text = qsTr("Показать информацию")
        } else {
            hideButtonImage.text = qsTr("Скрыть информацию")
        }

        imagePage.photoInformation.visible = !(imagePage.photoInformation.visible)
    }
    calibrateButtonImage.onClicked: {
        mainPage.mapComponent.instruments.calibrateButton.checked = true
    }
    gridButtonImage.onClicked: {
        if(gridNorth.visible == true){
            gridNorth.visible = false
            gridPicture.visible = true
        }else{
            gridNorth.visible = true
            gridPicture.visible = false
        }
    }
}
