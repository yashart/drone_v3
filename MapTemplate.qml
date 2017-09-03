import QtQuick 2.5
import QtLocation 5.5
import QtPositioning 5.3
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2

Map {
    property alias mouseAreaMap: mouseAreaMap
    property var currentTrack: -1
    property alias tempProviderImage: tempProviderImage
    property variant scaleLengths: [5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000, 100000, 200000, 500000, 1000000, 2000000]
    id: map
    anchors.fill: parent
    center: QtPositioning.coordinate(55.7463816, 37.55232)
    gesture.enabled: true
    copyrightsVisible: false

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        id: mouseAreaMap
        hoverEnabled: true

        property var currentMouseX: 0
        property var currentMouseY: 0

        onClicked: {
            if (mouse.button == Qt.LeftButton){ // Все события связанные с левой кнопкой мыши
                if(instruments.pointsButton.checked == true){
                    var point = map.toCoordinate(Qt.point(mouseX, mouseY))
                    popupPoints.set_popup_points_position(point.latitude, point.longitude, 0, "")
                    popupPoints.visible = true
                }

                if (instruments.rulerButton.checked == true){
                    rulerModel.addPoint(map.toCoordinate(Qt.point(mouseX, mouseY)));
                }

                if (instruments.missionButton.checked == true){
                    altitudeDialog.visible = true
                    mouseAreaMap.currentMouseX = mouseX
                    mouseAreaMap.currentMouseY = mouseY
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
                if (instruments.missionButton.checked == true){
                    missionModel.delPoint()
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
        id: startMissionPoint
        anchorPoint.x: startMissionIcon.width / 2;
        anchorPoint.y: startMissionIcon.height / 2;
        coordinate: missionModel.startPoint

        sourceItem: Image {
            id: startMissionIcon
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

    MapQuickItem {
        id: finishMissionPoint
        anchorPoint.x: finishMissionIcon.width / 2;
        anchorPoint.y: finishMissionIcon.height / 2;
        coordinate: missionModel.finishPoint

        sourceItem:
            Column{
                Image {id: finishMissionIcon; source: "qrc:/img/ruler/finish.png"}
        }
    }

    MapPolyline {
        line.width: 2
        line.color: 'red'
        path: rulerModel.rulerList
        smooth: true
    }

    MapPolyline {
        line.width: 2
        line.color: 'red'
        path: missionModel.missionList
        smooth: true
    }

    Dialog {
        id: altitudeDialog
        visible: false
        title: qsTr("Высота")
        standardButtons: StandardButton.Ok
        TextField {
            id: altitudeDialogText
            anchors.centerIn: parent
        }
        onAccepted: {
            var coord = map.toCoordinate
                    (Qt.point(mouseAreaMap.currentMouseX,
                              mouseAreaMap.currentMouseY))
            coord.altitude = parseFloat(altitudeDialogText.text)
            missionModel.addPoint(coord)
        }
    }

    MapItemView{
        id: tracksLines
        model: linesModel
        delegate: MapPolyline {
            line.width: 2
            line.color: color_track
            path: points
            z: 1
        }
    }

    MapItemView {

        model: photoPointer
        delegate:
            MapQuickItem{
            coordinate {
                latitude: lat
                longitude: lon
            }
            anchorPoint.x: dronePointer.width / 2;
            anchorPoint.y: dronePointer.height / 2;
            sourceItem:
                Column{
                    Image {id: dronePointer; source: "qrc:/img/drone.png"}
                    ColorOverlay {
                            anchors.fill: dronePointer
                            source: dronePointer
                            color: color_track
                        }
                }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log(color_track)
                }
            }
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

            sourceItem: Column {
                Image {
                    id: markerCustomPoint
                    source: "image://Icons/" + type
                }
                Text { text: label; font.bold: true }
            }
            MouseArea{
                anchors.fill: parent;
                onClicked: {
                    if( mouse.button == Qt.LeftButton){
                        popupPoints.set_popup_points_position(lat, lon, id, label)
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
        delegate: MapQuickItem {
            coordinate {
                latitude: lat
                longitude: lon
            }
            anchorPoint.x: calibratePoint.width / 2;
            anchorPoint.y: calibratePoint.height / 2;
            sourceItem: Image {
                id: calibratePoint
                source: "qrc:/img/point.png"
            }
        }
    }

    MapItemView {
        id: mapPictureRectangle
        model: imagePages.imagePageModel
        delegate: MapPolygon{
            color: 'red'
            opacity: 0.2
            z: 2

            property var leftHeight: QtPositioning.coordinate(parseFloat(JaCalibrate)*(-tempProviderImage.width/2) +
                                                      parseFloat(JbCalibrate)*(-tempProviderImage.height/2) +
                                                      parseFloat(Jlat),
                                                      parseFloat(JcCalibrate)*(-tempProviderImage.width/2) +
                                                      parseFloat(JdCalibrate)*(-tempProviderImage.height/2) +
                                                      parseFloat(Jlon))
            property var leftDown: QtPositioning.coordinate(parseFloat(JaCalibrate)*(-tempProviderImage.width/2) +
                                                      parseFloat(JbCalibrate)*(tempProviderImage.height/2) +
                                                      parseFloat(Jlat),
                                                      parseFloat(JcCalibrate)*(-tempProviderImage.width/2) +
                                                      parseFloat(JdCalibrate)*(tempProviderImage.height/2) +
                                                      parseFloat(Jlon))
            property var rightHeight: QtPositioning.coordinate(parseFloat(JaCalibrate)*(tempProviderImage.width/2) +
                                                      parseFloat(JbCalibrate)*(-tempProviderImage.height/2) +
                                                      parseFloat(Jlat),
                                                      parseFloat(JcCalibrate)*(tempProviderImage.width/2) +
                                                      parseFloat(JdCalibrate)*(-tempProviderImage.height/2) +
                                                      parseFloat(Jlon))
            property var rightDown: QtPositioning.coordinate(parseFloat(JaCalibrate)*(tempProviderImage.width/2) +
                                                      parseFloat(JbCalibrate)*(tempProviderImage.height/2) +
                                                      parseFloat(Jlat),
                                                      parseFloat(JcCalibrate)*(tempProviderImage.width/2) +
                                                      parseFloat(JdCalibrate)*(tempProviderImage.height/2) +
                                                      parseFloat(Jlon))
            path: [
                leftHeight,
                leftDown,
                rightDown,
                rightHeight
            ]
            Component.onCompleted: {
                console.log("newPath")
                console.log(leftHeight)
            }
        }

    }
/*
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
 */
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
                    var currentACalibrate = 0
                    var currentBCalibrate = 0
                    var currentCCalibrate = 0
                    var currentDCalibrate = 0
                    var currentDeltaLat = 0
                    var currentDeltaLon = 0

                    if(aCalibrate != ""){
                        currentACalibrate = aCalibrate
                        currentBCalibrate = bCalibrate
                        currentCCalibrate = cCalibrate
                        currentDCalibrate = dCalibrate
                    }

                    if ((mouse.button == Qt.LeftButton) && (mouse.modifiers & Qt.ShiftModifier))
                    {
                        if(tempProviderImage.aCalibrate != "")
                        {
                            currentACalibrate = parseFloat(tempProviderImage.aCalibrate)
                            currentBCalibrate = parseFloat(tempProviderImage.bCalibrate)
                            currentCCalibrate = parseFloat(tempProviderImage.cCalibrate)
                            currentDCalibrate = parseFloat(tempProviderImage.dCalibrate)
                            currentDeltaLat = tempProviderImage.deltaLat
                            currentDeltaLon = tempProviderImage.deltaLon

                            changedb.changePhotoLat(id, lat + tempProviderImage.deltaLat)
                            changedb.changePhotoLon(id, lon + tempProviderImage.deltaLon)
                            changedb.changePhotoGeoreferencing(parseInt(id), currentACalibrate, currentBCalibrate,
                                                               currentCCalibrate, currentDCalibrate)
                            pointsModel.updateModel()
                            tracksModel.updateModel()
                            linesModel.updateModel()
                        }

                        console.log("shift pressed")
                    }

                    map.currentTrack = track_id

                    imagePages.setPhotoParams(track_id, url, dir, tempProviderImage.height,
                                              azimuth, azimuth,
                                              lat + tempProviderImage.deltaLat,
                                              lon + tempProviderImage.deltaLon,
                                              alt, id, currentACalibrate, currentBCalibrate,
                                              currentCCalibrate, currentDCalibrate)
                    photoPointer.addPointer(track_id, lat, lon, color_track)

                    tempProviderImage.source = 'image://Photo/' + dir + url
                    tempProviderImage.lat = lat + tempProviderImage.deltaLat
                    tempProviderImage.lon = lon + tempProviderImage.deltaLon
                    tempProviderImage.id_photo = id

                    tempProviderImage.aCalibrate = currentACalibrate
                    tempProviderImage.bCalibrate = currentBCalibrate
                    tempProviderImage.cCalibrate = currentCCalibrate
                    tempProviderImage.dCalibrate = currentDCalibrate
                    tempProviderImage.deltaLat = currentDeltaLat
                    tempProviderImage.deltaLon = currentDeltaLon

                    console.log("tempImage Width: " + tempProviderImage.width)

                    console.log(dir + url)
                    console.log(url)

                    pointsPhotoModel.setCenter(lat + tempProviderImage.deltaLat, lon + tempProviderImage.deltaLon)

                    //dronePositionIcon.coordinate = QtPositioning.coordinate(lat, lon)
                }
            }
        }
    }

    Image {
        id: tempProviderImage
        visible: false
        source: ""
        fillMode: Image.PreserveAspectFit
        height: 500
        property var lat: 0
        property var lon: 0
        property var id_photo: 0
        property var aCalibrate: 0
        property var bCalibrate: 0
        property var cCalibrate: 0
        property var dCalibrate: 0
        property var deltaLat: 0
        property var deltaLon: 0
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
    Item {
        id: scale
        z: map.z + 3
        visible: scaleText.text != "0 m"
        anchors.bottom: parent.bottom;
        anchors.right: parent.right
        anchors.margins: 20
        height: scaleText.height * 2
        width: scaleImage.width

        Image {
            id: scaleImageLeft
            source: "qrc:/img/scale_end.png"
            anchors.bottom: parent.bottom
            anchors.right: scaleImage.left
        }
        Image {
            id: scaleImage
            source: "qrc:/img/scale.png"
            anchors.bottom: parent.bottom
            anchors.right: scaleImageRight.left
        }
        Image {
            id: scaleImageRight
            source: "qrc:/img/scale_end.png"
            anchors.bottom: parent.bottom
            anchors.right: parent.right
        }
        Label {
            id: scaleText
            color: "#004EAE"
            anchors.centerIn: parent
            text: "0 m"
        }
        Component.onCompleted: {
            map.calculateScale();
        }
    }

    Timer {
        interval: 500; running: true; repeat: true
        onTriggered: {
            telemetry.readGps()
        }
    }

    MapQuickItem {
        id: droneOnMapGps
        anchorPoint.x: droneOnMapGpsIcon.width / 2;
        anchorPoint.y: droneOnMapGpsIcon.height / 2;
        coordinate {
            latitude: telemetry.lat
            longitude: telemetry.lon
        }
        sourceItem:
            Column{
                Image {id: droneOnMapGpsIcon; source: "qrc:/img/drone.png"}
                ColorOverlay {
                    anchors.fill: droneOnMapGpsIcon
                    source: droneOnMapGpsIcon
                    color: "red"
                }
            }
    }

    Timer {
        id: scaleTimer
        interval: 100
        running: false
        repeat: false
        onTriggered: {
            map.calculateScale()
        }
    }

    onCenterChanged:{
        scaleTimer.restart()
    }

    onZoomLevelChanged: {
        scaleTimer.restart()
    }

    onWidthChanged:{
        scaleTimer.restart()
    }

    function calculateScale()
    {
        var coord1, coord2, dist, text, f
        f = 0
        coord1 = map.toCoordinate(Qt.point(0,scale.y))
        coord2 = map.toCoordinate(Qt.point(0+scaleImage.sourceSize.width,scale.y))
        dist = Math.round(coord1.distanceTo(coord2))

        if (dist === 0) {
            // not visible
        } else {
            for (var i = 0; i < scaleLengths.length-1; i++) {
                if (dist < (scaleLengths[i] + scaleLengths[i+1]) / 2 ) {
                    f = scaleLengths[i] / dist
                    dist = scaleLengths[i]
                    break;
                }
            }
            if (f === 0) {
                f = dist / scaleLengths[i]
                dist = scaleLengths[i]
            }
        }

        text = map.formatDistance(dist)
        scaleImage.width = (scaleImage.sourceSize.width * f) - 2 * scaleImageLeft.sourceSize.width
        scaleText.text = text
    }

    function formatDistance(meters)
    {
        var dist = Math.round(meters)
        if (dist > 1000 ){
            if (dist > 100000){
                dist = Math.round(dist / 1000)
            }
            else{
                dist = Math.round(dist / 100)
                dist = dist / 10
            }
            dist = dist + " km"
        }
        else{
            dist = dist + " m"
        }
        return dist
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

    /*
    function addViewCoordinates(leftHeight, leftDown, rightHeight, rightDown){
        var path = viewPort.path;
        path[0] = leftHeight;
        path[1] = leftDown;
        path[2] = rightDown;
        path[3] = rightHeight;
        viewPort.path = path;
    }
    */
}
