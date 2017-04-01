import QtQuick 2.7

CalibratePopupForm {
    clearCalibrateModelButton.onClicked: {
        calibrateModel.clear()
        calibrateModel.currentImage = 0
        calibrateModel.currentMap = 0
    }
    calibrateButton.onClicked: {
        variationModel.lat = 5
        console.log(variationModel.lat)
    }
}
