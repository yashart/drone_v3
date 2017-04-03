import QtQuick 2.4
import QtLocation 5.3
import QtPositioning 5.3


ImagePageForm {
    dragAreaPhoto.onWheel: {
        if (wheel.modifiers & Qt.ControlModifier) {
            currentPhoto.rotation += wheel.angleDelta.y / 120 * 5;
            if (Math.abs(currentPhoto.rotation) < 4)
                currentPhoto.rotation = 0;
        } else {
            currentPhoto.rotation += wheel.angleDelta.x / 120;
            if (Math.abs(currentPhoto.rotation) < 0.6)
                currentPhoto.rotation = 0;
            var scaleBefore = currentPhoto.scale;
            currentPhoto.scale += currentPhoto.scale * wheel.angleDelta.y / 120 / 10;
        }
    }
    dragAreaPhoto.onClicked: {
        if(instrumentsImage.pointsButtonImage.checked == true){
            popupPoints.visible = false
            console.log("id " + currentPhoto.id_photo )
            var coordinate = QtPositioning.coordinate(
                currentPhoto.lat + ((2*dragAreaPhoto.mouseX/currentPhoto.paintedWidth-1)*Math.sin(currentPhoto.azimuth*3.1415/180)-
                             (2*dragAreaPhoto.mouseY/currentPhoto.paintedHeight-1)*Math.cos(currentPhoto.azimuth*3.1415/180))*
                dragAreaPhoto.offsetLat,
                currentPhoto.lon + ((2*dragAreaPhoto.mouseX/currentPhoto.paintedWidth-1)*Math.cos(currentPhoto.azimuth*3.1415/180)+
                             (2*dragAreaPhoto.mouseY/currentPhoto.paintedHeight-1)*Math.sin(currentPhoto.azimuth*3.1415/180))*
                dragAreaPhoto.offsetLon
                )
            console.log("picture clicked: " + coordinate)
            popupPoints.set_popup_points_position(coordinate.latitude,
                                                  coordinate.longitude,
                                                  0)
            popupPoints.visible = true
        }
        if(instrumentsImage.calibrateButtonImage.checked == true){
            if(calibratePopup.calibrateModel.currentImage ==
                    calibratePopup.calibrateModel.count){
                calibratePopup.calibrateModel.append({
                "xPos": dragAreaPhoto.mouseX,
                "yPos": dragAreaPhoto.mouseY,
                "lat": -1,
                "lon": -1
                                                     })
                calibratePopup.calibrateModel.currentImage += 1
            }else{
                calibratePopup.calibrateModel.setProperty(
                            calibratePopup.calibrateModel.currentImage,
                            "xPos",
                            dragAreaPhoto.mouseX)
                calibratePopup.calibrateModel.setProperty(
                            calibratePopup.calibrateModel.currentImage,
                            "yPos",
                            dragAreaPhoto.mouseY)
                calibratePopup.calibrateModel.currentImage += 1
            }
        }
    }
    standartImageRadio.onClicked: {
        currentPhoto.source = "image://photo/" +
                currentPhoto.imageName +
                "/standart"
    }
    invertImageRadio.onClicked: {
        currentPhoto.source = "image://photo/" +
                currentPhoto.imageName +
                "/invert"
    }


    brightnessImageRadio.onCheckedChanged: {
        brghtnessImage.visible = brightnessImageRadio.checked;
    }
    colorizeImageRadio.onCheckedChanged: {
        colorizeImage.visible = colorizeImageRadio.checked;
    }
    gammaImageRadio.onCheckedChanged: {
        gammaImage.visible = gammaImageRadio.checked;
    }
    desaturateImageRadio.onCheckedChanged: {
        desaturateImage.visible = desaturateImageRadio.checked;
    }
    hueImageRadio.onCheckedChanged: {
        hueImage.visible = hueImageRadio.checked;
    }

    // Ползунки

    contrastSlider.onValueChanged: {
        brghtnessImage.contrast = contrastSlider.value
        //currentPhoto.source = "image://photo/" +
        //        currentPhoto.imageName +
        //        "/contrast/" + contrastSlider.value
    }
    brightnessSlider.onValueChanged:{
        brghtnessImage.brightness = brightnessSlider.value
    }
    colorizeSlider.onValueChanged: {
        colorizeImage.hue = colorizeSlider.value
    }
    gammaSlider.onValueChanged: {
        gammaImage.gamma = gammaSlider.value
    }
    desaturateSlider.onValueChanged: {
        desaturateImage.desaturation = desaturateSlider.value
    }
    hueSlider.onValueChanged: {
        hueImage.hue = hueSlider.value
    }
}
