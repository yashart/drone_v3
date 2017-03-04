import QtQuick 2.4

PopupPointsForm {

    popupPointsArea.onEntered: {
        opacity = 1
    }
    popupPointsArea.onExited: {
        opacity = 0.75
    }

    function set_popup_points_position(lat, lon, id){
        popupPointsForm.latitude = lat
        popupPointsForm.longitude = lon
        popupPointsForm.pointId = id
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
    triangleRadioButton.onClicked: {
        popupPoints.iconType = "triangle"
    }
    squareRadioButton.onClicked: {
        popupPoints.iconType = "square"
    }
    questionRadioButton.onClicked: {
        popupPoints.iconType = "question"
    }
    submitPopupButton.onClicked: {
        if(popupPoints.id == 0){
            dataBase.createLocalPoint(popupPoints.latitude,
                                      popupPoints.longitude,
                                      popupPointsForm.iconType + "/" +
                                      popupPointsForm.iconColor)
        }else{
            dataBase.prepareDeletePoint(popupPoints.pointId)
            dataBase.deleteLocalPoint()
            popupPoints.pointId = 0
            dataBase.createLocalPoint(popupPoints.latitude,
                                      popupPoints.longitude,
                                      popupPointsForm.iconType + "/" +
                                      popupPointsForm.iconColor)
        }
        popupPointsForm.visible = false

        //Вот тут пофикси как-нить
    }
    deletePointPopupButton.onClicked: {
        dataBase.prepareDeletePoint(popupPoints.pointId)
        dataBase.deleteLocalPoint()
        popupPoints.pointId = 0
        popupPointsForm.visible = false
    }
}
