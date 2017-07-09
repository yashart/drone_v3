import QtQuick 2.4

PopupPointsForm {

    popupPointsArea.onEntered: {
        opacity = 1
    }
    popupPointsArea.onExited: {
        opacity = 0.75
    }

    function set_popup_points_position(lat, lon, id, label){
        popupPointsForm.latitude = lat
        popupPointsForm.longitude = lon
        popupPointsForm.pointId = id
        popupPointsForm.label = label
        popupPoints.label = label
    }

    redRadioButton.onClicked: {
        popupPoints.iconColor = "red"
    }
    greenRadioButton.onClicked: {
        popupPoints.iconColor = "green"
    }
    blackRadioButton.onClicked: {
        popupPoints.iconColor = "black"
    }
    yellowRadioButton.onClicked: {
        popupPoints.iconColor = "yellow"
    }
    blueRadioButton.onClicked: {
        popupPoints.iconColor = "blue"
    }

    tankLightRadioButton.onClicked: {
        popupPoints.iconType = "tank_light"
    }
    tankMediumRadioButton.onClicked: {
        popupPoints.iconType = "tank_medium"
    }
    tankHeavyRadioButton.onClicked: {
        popupPoints.iconType = "tank_heavy"
    }
    btrRadioButton.onClicked: {
        popupPoints.iconType = "btr"
    }
    bmpRadioButton.onClicked: {
        popupPoints.iconType = "bmp"
    }
    gunRadioButton.onClicked: {
        popupPoints.iconType = "machine_gun"
    }

    submitPopupButton.onClicked: {
        if(popupPoints.id == 0){
            dataBase.createLocalPoint(popupPoints.latitude,
                                      popupPoints.longitude,
                                      popupPointsForm.iconType + "/" +
                                      popupPointsForm.iconColor,
                                      labelField.text)
            console.log(">>" + popupPoints.label + " " +popupPointsForm.label);
        }else{
            dataBase.prepareDeletePoint(popupPoints.pointId)
            dataBase.deleteLocalPoint()
            popupPoints.pointId = 0
            dataBase.createLocalPoint(popupPoints.latitude,
                                      popupPoints.longitude,
                                      popupPointsForm.iconType + "/" +
                                      popupPointsForm.iconColor,
                                      labelField.text)
             console.log(">>>" + popupPoints.label + " " +popupPointsForm.label);
        }
        popupPointsForm.visible = false

        //Вот тут пофикси
    }
    deletePointPopupButton.onClicked: {
        dataBase.prepareDeletePoint(popupPoints.pointId)
        dataBase.deleteLocalPoint()
        popupPoints.pointId = 0
        popupPointsForm.visible = false
    }
}
