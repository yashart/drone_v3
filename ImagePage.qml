import QtQuick 2.7
import QtLocation 5.3
import QtPositioning 5.3


ImagePageForm {
    dragAreaPhoto.onWheel: {
        if (wheel.modifiers & Qt.ControlModifier) {
            currentPhoto.rotation += wheel.angleDelta.y / 120 * 5;
            console.log("rotation: " + currentPhoto.rotation)
            if (Math.abs(currentPhoto.rotation) < 4)
                currentPhoto.rotation = 0;
        } else {
            if(wheel.angleDelta.y > 0)  // zoom in
                                var zoomFactor = dragAreaPhoto.factor
                            else                        // zoom out
                                zoomFactor = 1/dragAreaPhoto.factor

            currentPhoto.rotation += wheel.angleDelta.x / 120;
            if (Math.abs(currentPhoto.rotation) < 0.6)
                currentPhoto.rotation = 0;
            var scaleBefore = currentPhoto.scale;

            var realX = wheel.x * transformImage.xScale
            var realY = wheel.y * transformImage.yScale

            currentPhoto.x += (1-zoomFactor)*realX
            currentPhoto.y += (1-zoomFactor)*realY

            transformImage.xScale *= zoomFactor
            transformImage.yScale *= zoomFactor

            //currentPhoto.scale += currentPhoto.scale * wheel.angleDelta.y / 120 / 10;

            var pictureViewerCoordinates = currentPhoto.mapToItem(pictureViewer, 0, 0)

            //currentPhoto.x += (dragAreaPhoto.mouseX - currentPhoto.width/2) *
            //        (scaleBefore -  dragAreaPhoto.scale)

            //currentPhoto.x -= dragAreaPhoto.mouseX - currentPhoto.width/2
            //currentPhoto.y -= dragAreaPhoto.mouseY - currentPhoto.height/2
            gridPicture.gridCanvas.clear_canvas()
            gridNorth.gridCanvas.clear_canvas()
        }
    }
    dragAreaPhoto.onClicked: {
        if(instrumentsImage.pointsButtonImage.checked == true){
            popupPoints.visible = false
            console.log("id " + currentPhoto.id_photo )
            var coordinate = QtPositioning.coordinate(
                currentPhoto.lat + currentPhoto.aCalibrate*
                        (dragAreaPhoto.mouseX - currentPhoto.width/2) +
                        currentPhoto.bCalibrate*
                        (dragAreaPhoto.mouseY - currentPhoto.height/2),
                currentPhoto.lon + currentPhoto.cCalibrate*
                        (dragAreaPhoto.mouseX - currentPhoto.width/2) +
                        currentPhoto.dCalibrate*
                        (dragAreaPhoto.mouseY - currentPhoto.height/2)
                )
            console.log("picture clicked: " + coordinate)
            popupPoints.set_popup_points_position(coordinate.latitude,
                                                  coordinate.longitude,
                                                  0,
                                                  popupPoints.label)
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
}
