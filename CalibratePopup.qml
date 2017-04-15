import QtQuick 2.7
import QtPositioning 5.3

CalibratePopupForm {
    clearCalibrateModelButton.onClicked: {
        calibrateModel.clear()
        calibrateModel.currentImage = 0
        calibrateModel.currentMap = 0
    }
    calibrateButton.onClicked: {
        var itemCount = 0;
        if(calibrateModel.currentImage >= calibrateModel.currentMap){
            itemCount = calibrateModel.currentImage
        }else{
            itemCount = calibrateModel.currentMap
        }

        for (var i = 0; i < itemCount; i++){
            var plat = calibrateModel.get(i).lat
            var plon = calibrateModel.get(i).lon
            console.log("width: " + mainPage.mapComponent.newMap.tempProviderImage.width)
            var x = calibrateModel.get(i).xPos - mainPage.mapComponent.newMap.tempProviderImage.width/2
            var y = calibrateModel.get(i).yPos - mainPage.mapComponent.newMap.tempProviderImage.height/2
            console.log(plat, plon, x, y)

            variationModel.add_info(plat, plon, x, y)
        }
        variationModel.lat = mainPage.mapComponent.newMap.tempProviderImage.lat
        variationModel.lon = mainPage.mapComponent.newMap.tempProviderImage.lon
        variationModel.a = 0
        variationModel.b = 0
        variationModel.c = 0
        variationModel.d = 0

        console.log("")

        variationModel.calcMethod()
        //imagePage.currentPhoto.lat = variationModel.lat
        //imagePage.currentPhoto.lon = variationModel.lon
        //imagePage.currentPhoto.azimuth = variationModel.fi
    /*
        var leftHeight = QtPositioning.coordinate(variationModel.a*(-mainPage.mapComponent.newMap.tempProviderImage.width/2) +
                                                  variationModel.b*(-mainPage.mapComponent.newMap.tempProviderImage.height/2) +
                                                  variationModel.lat,
                                                  variationModel.c*(-mainPage.mapComponent.newMap.tempProviderImage.width/2) +
                                                  variationModel.d*(-mainPage.mapComponent.newMap.tempProviderImage.height/2) +
                                                  variationModel.lon)
        var leftDown = QtPositioning.coordinate(variationModel.a*(-mainPage.mapComponent.newMap.tempProviderImage.width/2) +
                                                  variationModel.b*(mainPage.mapComponent.newMap.tempProviderImage.height/2) +
                                                  variationModel.lat,
                                                  variationModel.c*(-mainPage.mapComponent.newMap.tempProviderImage.width/2) +
                                                  variationModel.d*(mainPage.mapComponent.newMap.tempProviderImage.height/2) +
                                                  variationModel.lon)
        var rightHeight = QtPositioning.coordinate(variationModel.a*(mainPage.mapComponent.newMap.tempProviderImage.width/2) +
                                                  variationModel.b*(-mainPage.mapComponent.newMap.tempProviderImage.height/2) +
                                                  variationModel.lat,
                                                  variationModel.c*(mainPage.mapComponent.newMap.tempProviderImage.width/2) +
                                                  variationModel.d*(-mainPage.mapComponent.newMap.tempProviderImage.height/2) +
                                                  variationModel.lon)
        var rightDown = QtPositioning.coordinate(variationModel.a*(mainPage.mapComponent.newMap.tempProviderImage.width/2) +
                                                  variationModel.b*(mainPage.mapComponent.newMap.tempProviderImage.height/2) +
                                                  variationModel.lat,
                                                  variationModel.c*(mainPage.mapComponent.newMap.tempProviderImage.width/2) +
                                                  variationModel.d*(mainPage.mapComponent.newMap.tempProviderImage.height/2) +
                                                  variationModel.lon)
        mainPage.mapComponent.newMap.addViewCoordinates(leftHeight, leftDown, rightHeight, rightDown)
        */
        var id_photo = mainPage.mapComponent.newMap.tempProviderImage.id_photo
        changedb.changePhotoLat(id_photo, mainPage.mapComponent.newMap.tempProviderImage.lat)
        changedb.changePhotoLon(id_photo, mainPage.mapComponent.newMap.tempProviderImage.lon)
        changedb.changePhotoGeoreferencing(id_photo, variationModel.a, variationModel.b,
                                           variationModel.c, variationModel.d)
        linesModel.updateModel()
        pointsModel.updateModel()

        //imagePage.currentPhoto.aCalibrate = variationModel.a
        //imagePage.currentPhoto.bCalibrate = variationModel.b
        //imagePage.currentPhoto.cCalibrate = variationModel.c
        //imagePage.currentPhoto.dCalibrate = variationModel.d

        variationModel.infoCount = 0
    }
}
