import QtQuick 2.4

PopupPointsForm {

    popupPointsArea.onEntered: {
        opacity = 1
    }
    popupPointsArea.onExited: {
        opacity = 0.75
    }

    function set_popup_points_position(lat, lon){
        popupPointsForm.latitude = lat
        popupPointsForm.longitude = lon
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
        dataBase.createLocalPoint(popupPoints.latitude,
                                  popupPoints.longitude,
                                  popupPointsForm.iconType + "/" +
                                  popupPointsForm.iconColor)
        //Вот тут пофикси как-нить
    }
    cancelPopupButton.onClicked: {
        popupPointsForm.visible = false
    }
}
