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
    mouseButton.onClicked: {
        rulerPopup.visible = false
    }
    savePointsButton.onClicked: {
        rulerPopup.visible = false
    }
    calibrateButton.onClicked: {
        imagePage.instrumentsImage.calibrateButtonImage.checked = true
        rulerPopup.visible = false
    }
    calibrateShowButton.onClicked: {
        if(calibratePopup.visible == true)
        {
            calibratePopup.visible = false
        }else{
            calibratePopup.visible = true
        }
    }
    tracksMapButton.onClicked: {
        if(leftTabMenu.visible == true)
        {
            leftTabMenu.visible = false
        }else{
            leftTabMenu.visible = true
        }
    }
    startMissionButton.onClicked: {
        console.log("123");
        link.down()
        //communicator.removeLink(link)
        missionModel.makeMision()
        //communicator.addLink(link, 0);
        link.up()
    }
    copterInfoButton.onClicked: {
        if(flightInfo.visible == true)
        {
            flightInfo.visible = false
        }else{
            flightInfo.visible = true
        }
    }
}
