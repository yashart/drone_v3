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

        mainPage.mapComponent.newMap.tempProviderImage.deltaLat = variationModel.lat -
                mainPage.mapComponent.newMap.tempProviderImage.lat
        mainPage.mapComponent.newMap.tempProviderImage.deltaLon = variationModel.lon -
                mainPage.mapComponent.newMap.tempProviderImage.lon

        console.log("delta Lon: " + mainPage.mapComponent.newMap.tempProviderImage.deltaLon)

        var id_photo = mainPage.mapComponent.newMap.tempProviderImage.id_photo
        changedb.changePhotoLat(id_photo, variationModel.lat)
        changedb.changePhotoLon(id_photo, variationModel.lon)
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
