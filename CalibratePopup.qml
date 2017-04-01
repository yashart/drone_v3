import QtQuick 2.7

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
        variationModel.fi = imagePage.currentPhoto.azimuth
        variationModel.offsetX = 0.000005
        variationModel.offsetY = -0.0000019

        console.log(imagePage.currentPhoto.lat,
                    imagePage.currentPhoto.lon,
                    imagePage.currentPhoto.azimuth,
                    variationModel.offsetX,
                    variationModel.offsetY
                    )

        variationModel.calcMethod()
        imagePage.currentPhoto.lat = variationModel.lat
        imagePage.currentPhoto.lon = variationModel.lon
        imagePage.currentPhoto.azimuth = variationModel.fi

        console.log(imagePage.currentPhoto.lat,
                    imagePage.currentPhoto.lon,
                    imagePage.currentPhoto.azimuth,
                    variationModel.offsetX,
                    variationModel.offsetY
                    )
        mainPage.mapComponent.newMap.changeViewPortCenter(imagePage.currentPhoto.lat,
                                                             imagePage.currentPhoto.lon,
                                                             imagePage.currentPhoto.azimuth,
                                                             variationModel.offsetX*imagePage.currentPhoto.width/2,
                                                             variationModel.offsetY*imagePage.currentPhoto.height/2
                                                             )

        //imagePage.currentPhoto.off = variationModel.lat

    }
}
