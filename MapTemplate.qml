import QtQuick 2.0
import QtLocation 5.3
import QtPositioning 5.3

Map {
    property alias mouseAreaMap: mouseAreaMap
    id: map
    anchors.fill: parent
    center: QtPositioning.coordinate(59.91, 10.75)
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        id: mouseAreaMap
        hoverEnabled: true

        onClicked: {
            if (mouse.button == Qt.LeftButton){ // Все события связанные с левой кнопкой мыши
                if(instruments.pointsButton.checked == true){
                    var point = map.toCoordinate(Qt.point(mouseX, mouseY))
                    popupPoints.set_popup_points_position(point.latitude, point.longitude, 0)
                    popupPoints.visible = true
                }

                if (instruments.rulerButton.checked == true){
                    rulerModel.addPoint(map.toCoordinate(Qt.point(mouseX, mouseY)));
                }

                if (instruments.savePointsButton.checked == true){
                    if (saveArea.visible == false){
                        saveArea.topLeft = map.toCoordinate(Qt.point(mouseX, mouseY))
                        saveArea.visible = true
                    } else{
                        saveArea.visible = false
                        var lat1 = saveArea.topLeft.latitude
                        var lon1 = saveArea.topLeft.longitude
                        var lat2 = saveArea.bottomRight.latitude
                        var lon2 = saveArea.bottomRight.longitude
                        tilesDownloader.downloadTiles(lat1, lon1, lat2, lon2);
                        //TODO: send tiles coordinates
                    }
                }
                if(instruments.calibrateButton.checked == true){
                    if(calibratePopup.calibrateModel.currentMap ==
                            calibratePopup.calibrateModel.count){
                        calibratePopup.calibrateModel.append({
                        "xPos": -1,
                        "yPos": -1,
                        "lat": map.toCoordinate(Qt.point(mouseX, mouseY)).latitude,
                        "lon": map.toCoordinate(Qt.point(mouseX, mouseY)).longitude
                                                             })
                        calibratePopup.calibrateModel.currentMap += 1
                    }else{
                        calibratePopup.calibrateModel.setProperty(
                                    calibratePopup.calibrateModel.currentMap,
                                    "lat",
                                    map.toCoordinate(Qt.point(mouseX, mouseY)).latitude)
                        calibratePopup.calibrateModel.setProperty(
                                    calibratePopup.calibrateModel.currentMap,
                                    "lon",
                                    map.toCoordinate(Qt.point(mouseX, mouseY)).longitude)
                        calibratePopup.calibrateModel.currentMap += 1
                    }
                }
            }

            if (mouse.button == Qt.RightButton){ //Все события связанные с правой кнопкой мыши
                if (instruments.rulerButton.checked == true){
                   rulerModel.delPoint();
                }
            }
        }
        onPositionChanged: {
            if (instruments.rulerButton.checked == true){
                rulerPopup.x = mouseX + 25
                rulerPopup.y = mouseY + 25
                rulerModel.distanceToMouse(map.toCoordinate(Qt.point(mouseX, mouseY)));
                var checkdistance = rulerModel.checkPoint;
            }
            if (instruments.savePointsButton.checked == true){
                saveArea.bottomRight = map.toCoordinate(Qt.point(mouseX, mouseY))
            }
        }
    }

    MapQuickItem {
        id: startRulerPoint
        anchorPoint.x: startRulerIcon.width / 2;
        anchorPoint.y: startRulerIcon.height / 2;
        coordinate: rulerModel.startPoint

        sourceItem: Image {
            id: startRulerIcon
            source: "qrc:/img/ruler/start.png"
        }
    }

    MapQuickItem {
        id: finishRulerPoint
        anchorPoint.x: finishRulerIcon.width / 2;
        anchorPoint.y: finishRulerIcon.height / 2;
        coordinate: rulerModel.finishPoint

        sourceItem:
            Column{
                Image {id: finishRulerIcon; source: "qrc:/img/ruler/finish.png"}
                Text {text: rulerModel.distance; font.bold: true; color: "#5518e2"}
        }
    }

    MapPolyline {
        line.width: 2
        line.color: 'red'
        path: rulerModel.rulerList
        smooth: true
    }

    MapItemView{
        id: tracksLines
        model: linesModel
        delegate: MapPolyline {
            line.width: 2
            line.color: 'blue'
            path: points
            z: 1
        }
    }
    MapItemView {
        id: locationListView

        model: locationsModel
        delegate: MapQuickItem {
            coordinate {
                latitude: lat
                longitude: lon
            }
            anchorPoint.x: markerCustomPoint.width / 2;
            anchorPoint.y: markerCustomPoint.height / 2;
            sourceItem: Image {
                id: markerCustomPoint
                source: "/img/popupIconsSet/" + type + ".png"
            }
            MouseArea{
                anchors.fill: parent;
                onClicked: {
                    if( mouse.button == Qt.LeftButton){
                        popupPoints.set_popup_points_position(lat, lon, id)
                        popupPoints.visible = true
                    }
                }
            }
        }
    }

    MapItemView {
        id: cutListView

        model: pointsPhotoModel
        delegate: MapQuickItem {
            coordinate {
                latitude: lat
                longitude: lon
            }
            anchorPoint.x: markerLkPoint.width / 2;
            anchorPoint.y: markerLkPoint.height / 2;
            sourceItem: Image {
                id: markerLkPoint
                source: "/img/popupIconsSet/" + type + ".png"
            }
        }
    }
    MapItemView {
        id: calibrateMapView
        model: calibratePopup.calibrateModel
        delegate: MapCircle {
            center {
                latitude: lat
                longitude: lon
            }
            radius: 2
            color: "red"
        }
    }

    MapPolygon{
        id: viewPort
        color: 'green'
        opacity: 0.5
        z: 2
        path: [
            { latitude: 0, longitude: 0},
            { latitude: 0, longitude: 0},
            { latitude: 0, longitude: 0},
            { latitude: 0, longitude: 0}
        ]
    }
    MapPolyline {
       id: lookAt
       line.width: 4
       line.color: 'red'
       path:[
           { latitude: 0, longitude: 0},
           { latitude: 0, longitude: 0},
       ]
    }
    MapItemView {
        id: pointsOnTrack
        model: pointsModel
        delegate: MapQuickItem {
            coordinate: QtPositioning.coordinate(lat, lon)
            anchorPoint.x: markerTrackPoint.width / 2;
            anchorPoint.y: markerTrackPoint.height / 2;
            opacity: 0
            sourceItem: Image {
                id: markerTrackPoint
                z: 2
                source: "/img/photo.png"
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    parent.opacity = 1;

                }
                onExited: {
                    parent.opacity = 0;
                }
                onClicked: {
                    var radAzimuth = toRad(azimuth)
                    var scaleCoeff = 0.0007
                    var leftHeight = QtPositioning.coordinate(-Math.cos(radAzimuth)*scaleCoeff -
                                                              Math.sin(radAzimuth)*scaleCoeff +
                                                              lat,
                                                              -Math.cos(radAzimuth)*scaleCoeff +
                                                              Math.sin(radAzimuth)*scaleCoeff +
                                                              lon)
                    var leftDown = QtPositioning.coordinate(-Math.cos(radAzimuth)*scaleCoeff +
                                                            Math.sin(radAzimuth)*scaleCoeff +
                                                            lat,
                                                            -Math.cos(radAzimuth)*scaleCoeff -
                                                            Math.sin(radAzimuth)*scaleCoeff +
                                                            lon)
                    var rightHeight = QtPositioning.coordinate(Math.cos(radAzimuth)*scaleCoeff -
                                                               Math.sin(radAzimuth)*scaleCoeff +
                                                               lat,
                                                               Math.cos(radAzimuth)*scaleCoeff +
                                                               Math.sin(radAzimuth)*scaleCoeff +
                                                               lon)
                    var rightDown = QtPositioning.coordinate(Math.cos(radAzimuth)*scaleCoeff +
                                                             Math.sin(radAzimuth)*scaleCoeff +
                                                             lat,
                                                             Math.cos(radAzimuth)*scaleCoeff -
                                                             Math.sin(radAzimuth)*scaleCoeff +
                                                             lon)
                    console.log(radAzimuth)

                    addViewCoordinates(leftHeight, leftDown, rightHeight, rightDown)

                    imagePage.currentPhoto.source = 'image://Photo/' + url //Для работы изображений используется провайдер
                    imagePage.currentPhoto.height = imagePage.pictureViewer.height
                    imagePage.currentPhoto.rotation = azimuth
                    imagePage.currentPhoto.azimuth = azimuth
                    imagePage.currentPhoto.lat = lat
                    imagePage.currentPhoto.lon = lon
                    imagePage.currentPhoto.alt = alt
                    imagePage.currentPhoto.id_photo = id
                    console.log(imagePage.currentPhoto.source)
                    imagePage.currentPhoto
                    imagePage.currentPhoto.imageName = url
                    console.log(dir + url)
                    console.log(url)
                    pointsPhotoModel.setCenter(lat, lon)
                    imagePage.visible = true
                }
            }
        }
    }

    MapRectangle {
        id: saveArea
        color: 'green'
        border.width: 2
        z: 3
        topLeft {
            latitude: 0
            longitude: 0
        }
        bottomRight {
            latitude: 0
            longitude: 0
        }
        visible: false
        opacity: 0.5
    }

    function getGoogleTiles(){
        console.log("TODO: Get tiles")
    }

    function rotLat(lat, lon, angle) // матрица поворота для широты https://ru.wikipedia.org/wiki/Матрица_поворота#.D0.9C.D0.B0.D1.82.D1.80.D0.B8.D1.86.D0.B0_.D0.BF.D0.BE.D0.B2.D0.BE.D1.80.D0.BE.D1.82.D0.B0_.D0.B2_.D0.B4.D0.B2.D1.83.D0.BC.D0.B5.D1.80.D0.BD.D0.BE.D0.BC_.D0.BF.D1.80.D0.BE.D1.81.D1.82.D1.80.D0.B0.D0.BD.D1.81.D1.82.D0.B2.D0.B5
    {
        angle = toRad(angle);
        return lat * Math.cos(angle) + lon * Math.sin(angle);
    }
    function rotLon(lat, lon, angle){ // матрица поворота для долготы
        angle = toRad(angle);
        return -lat * Math.sin(angle) + lon * Math.cos(angle);
    }
    function toDeg (angle) {           // функция преобразования радианов в градусы
      return angle * (180 / Math.PI);
    }
    function toRad (angle) {           // функция преобразования градусов в радианы
      return angle * (Math.PI / 180);
    }

    function addViewCoordinates(leftHeight, leftDown, rightHeight, rightDown){
        var path = viewPort.path;
        path[0] = leftHeight;
        path[1] = leftDown;
        path[2] = rightDown;
        path[3] = rightHeight;
        viewPort.path = path;
    }
}
