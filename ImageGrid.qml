import QtQuick 2.7
import QtPositioning 5.2

Item {
    property alias gridCanvas: gridCanvas
    Canvas {
        id: gridCanvas
        anchors.fill: parent
        property var lineHeight: 100
        property var lineWidth: 100
        onPaint: {
            var ctx = getContext("2d")
            ctx.strokeStyle = "black"
            ctx.fillStyle = "black"
            ctx.beginPath()
            if(parent.currentParent == "picture") {
                ctx.lineWidth = 2 / Math.ceil(currentPhoto.scale)
                if(ctx.lineWidth < 1){
                    ctx.lineWidth = 1
                }

                console.log(Math.ceil(currentPhoto.scale))
                for (var i = 1; i < height/lineHeight*Math.ceil(currentPhoto.scale); i++) {
                    ctx.moveTo(0, lineHeight / Math.ceil(currentPhoto.scale) * i)
                    ctx.lineTo(width ,lineHeight / Math.ceil(currentPhoto.scale) * i)
                    if(currentPhoto.aCalibrate == 0) {
                        ctx.fillStyle = "red"
                        ctx.fillText(Math.ceil(i * lineHeight / Math.ceil(currentPhoto.scale)),
                                     0, lineHeight / Math.ceil(currentPhoto.scale) * i)
                        ctx.fillStyle = "black"
                    }else {
                        var distance = rulerModel.distanceBetween(
                                    QtPositioning.coordinate(currentPhoto.lat,
                                                             currentPhoto.lon),
                                    QtPositioning.coordinate(currentPhoto.bCalibrate*lineHeight/Math.ceil(currentPhoto.scale)*i +
                                                             currentPhoto.lat,
                                                             currentPhoto.dCalibrate*lineHeight/Math.ceil(currentPhoto.scale)*i +
                                                             currentPhoto.lon))
                        ctx.fillText(Math.ceil(distance),
                                     0, lineHeight / Math.ceil(currentPhoto.scale) * i)
                    }
                }
                for (var i = 1; i < width/lineWidth*Math.ceil(currentPhoto.scale); i++) {
                    ctx.moveTo(lineWidth / Math.ceil(currentPhoto.scale) * i, 0)
                    ctx.lineTo(lineWidth / Math.ceil(currentPhoto.scale) * i, height)
                    ctx.rotate(Math.PI/2);
                    if(currentPhoto.aCalibrate == 0) {
                        ctx.fillStyle = "red"
                        ctx.fillText(Math.ceil(i * lineWidth / Math.ceil(currentPhoto.scale)),
                                    0, -lineWidth / Math.ceil(currentPhoto.scale) * i)
                        ctx.fillStyle = "black"
                    }else {
                        var distance = rulerModel.distanceBetween(
                                    QtPositioning.coordinate(currentPhoto.lat,
                                                             currentPhoto.lon),
                                    QtPositioning.coordinate(currentPhoto.aCalibrate*lineWidth/Math.ceil(currentPhoto.scale)*i +
                                                             currentPhoto.lat,
                                                             currentPhoto.cCalibrate*lineWidth/Math.ceil(currentPhoto.scale)*i +
                                                             currentPhoto.lon))
                        ctx.fillText(Math.ceil(Math.ceil(distance)),
                                    0, -lineWidth / Math.ceil(currentPhoto.scale) * i)
                    }

                    ctx.rotate(-Math.PI/2);
                }
            }else {
                ctx.lineWidth = 2 / Math.ceil(currentPhoto.scale)
                if(ctx.lineWidth < 1){
                    ctx.lineWidth = 1
                }

                console.log(Math.ceil(currentPhoto.scale))
                for (var i = 1; i < height/lineHeight; i++) {
                    ctx.moveTo(0, lineHeight * i)
                    ctx.lineTo(width ,lineHeight * i)
                    if(currentPhoto.aCalibrate == 0) {
                        ctx.fillStyle = "red"
                        ctx.fillText(Math.ceil(i * lineHeight / Math.ceil(currentPhoto.scale)),
                                     0, lineHeight * i)
                        ctx.fillStyle = "black"
                    }else {
                        var distance = rulerModel.distanceBetween(
                                    QtPositioning.coordinate(currentPhoto.lat,
                                                             currentPhoto.lon),
                                    QtPositioning.coordinate(currentPhoto.bCalibrate*lineHeight/Math.ceil(currentPhoto.scale)*i +
                                                             currentPhoto.lat,
                                                             currentPhoto.dCalibrate*lineHeight/Math.ceil(currentPhoto.scale)*i +
                                                             currentPhoto.lon))
                        ctx.fillText(Math.ceil(distance),
                                     0, lineHeight * i)
                    }
                }
                for (var i = 1; i < width/lineWidth; i++) {
                    ctx.moveTo(lineWidth * i, 0)
                    ctx.lineTo(lineWidth * i, height)
                    ctx.rotate(Math.PI/2);
                    if(currentPhoto.aCalibrate == 0) {
                        ctx.fillStyle = "red"
                        ctx.fillText(Math.ceil(i * lineWidth / Math.ceil(currentPhoto.scale)),
                                    0, -lineWidth * i)
                        ctx.fillStyle = "black"
                    }else {
                        var distance = rulerModel.distanceBetween(
                                    QtPositioning.coordinate(currentPhoto.lat,
                                                             currentPhoto.lon),
                                    QtPositioning.coordinate(currentPhoto.aCalibrate*lineWidth/Math.ceil(currentPhoto.scale)*i +
                                                             currentPhoto.lat,
                                                             currentPhoto.cCalibrate*lineWidth/Math.ceil(currentPhoto.scale)*i +
                                                             currentPhoto.lon))
                        ctx.fillText(Math.ceil(Math.ceil(distance)),
                                    0, -lineWidth * i)
                    }

                    ctx.rotate(-Math.PI/2);
                }
            }

            ctx.stroke()
        }

        function clear_canvas() {
            var ctx = getContext("2d");
            ctx.reset();
            requestPaint();
        }
    }
}
