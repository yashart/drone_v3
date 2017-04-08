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
            var x = calibrateModel.get(i).xPos - imagePage.currentPhoto.width/2
            var y = calibrateModel.get(i).yPos - imagePage.currentPhoto.height/2
            console.log(plat, plon, x, y)

            variationModel.add_info(plat, plon, x, y)
        }
        variationModel.lat = imagePage.currentPhoto.lat
        variationModel.lon = imagePage.currentPhoto.lon
        variationModel.a = 0
        variationModel.b = 0
        variationModel.c = 0
        variationModel.d = 0

        variationModel.calcMethod()
        imagePage.currentPhoto.lat = variationModel.lat
        imagePage.currentPhoto.lon = variationModel.lon
        imagePage.currentPhoto.azimuth = variationModel.fi

        console.log("offset: " + variationModel.offsetX + variationModel.a)
        var leftHeight = QtPositioning.coordinate(variationModel.a*(-imagePage.currentPhoto.width/2) +
                                                  variationModel.b*(-imagePage.currentPhoto.height/2) +
                                                  variationModel.lat,
                                                  variationModel.c*(-imagePage.currentPhoto.width/2) +
                                                  variationModel.d*(-imagePage.currentPhoto.height/2) +
                                                  variationModel.lon)
        var leftDown = QtPositioning.coordinate(variationModel.a*(-imagePage.currentPhoto.width/2) +
                                                  variationModel.b*(imagePage.currentPhoto.height/2) +
                                                  variationModel.lat,
                                                  variationModel.c*(-imagePage.currentPhoto.width/2) +
                                                  variationModel.d*(imagePage.currentPhoto.height/2) +
                                                  variationModel.lon)
        var rightHeight = QtPositioning.coordinate(variationModel.a*(imagePage.currentPhoto.width/2) +
                                                  variationModel.b*(-imagePage.currentPhoto.height/2) +
                                                  variationModel.lat,
                                                  variationModel.c*(imagePage.currentPhoto.width/2) +
                                                  variationModel.d*(-imagePage.currentPhoto.height/2) +
                                                  variationModel.lon)
        var rightDown = QtPositioning.coordinate(variationModel.a*(imagePage.currentPhoto.width/2) +
                                                  variationModel.b*(imagePage.currentPhoto.height/2) +
                                                  variationModel.lat,
                                                  variationModel.c*(imagePage.currentPhoto.width/2) +
                                                  variationModel.d*(imagePage.currentPhoto.height/2) +
                                                  variationModel.lon)
        mainPage.mapComponent.newMap.addViewCoordinates(leftHeight, leftDown, rightHeight, rightDown)

        var id_photo = imagePage.currentPhoto.id_photo;
        //changedb.changePhotoLat(id_photo, imagePage.currentPhoto.lat);
        //changedb.changePhotoLon(id_photo, imagePage.currentPhoto.lon);
        //changedb.changePhotoAzimuth(id_photo, imagePage.currentPhoto.azimuth);
        //changedb.changePhotoOffsetX(id_photo, variationModel.offsetX);
        //changedb.changePhotoOffsetY(id_photo, variationModel.offsetY);

        variationModel.infoCount = 0

        //imagePage.currentPhoto.off = variationModel.lat

    }
}
