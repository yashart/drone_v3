import QtQuick 2.0
import QtLocation 5.6
import QtPositioning 5.3
import QtQuick.Controls 1.4

Item {
    id: mapComponent
    property alias osmPlugin: osmPlugin
    property alias mapboxPlugin: mapboxPlugin
    property alias esriPlugin: esriPlugin
    property alias herePlugin: herePlugin
    property alias customPlugin: customPlugin
    property alias rulerPopup: rulerPopup
    property var newMap: defaultInitMap(osmPlugin)

    function defaultInitMap(plugin){
        var defaultMap = null
        defaultMap = Qt.createComponent("MapTemplate.qml");
        defaultMap = defaultMap.createObject(mapComponent);
        defaultMap.plugin = plugin;
        defaultMap.zoomLevel = (defaultMap.maximumZoomLevel - defaultMap.minimumZoomLevel)/2
        defaultMap.forceActiveFocus();
        return defaultMap
    }

    function createMap(plugin){
        var zoomLevel = null;
        var center = null;
        if (newMap) {
            zoomLevel = newMap.zoomLevel;
            center = newMap.center;
            newMap.destroy();
        }
        newMap = Qt.createComponent("MapTemplate.qml");
        newMap = newMap.createObject(mapComponent);
        console.log(newMap);
        newMap.plugin = plugin;

        if (zoomLevel != null) {
            newMap.zoomLevel = zoomLevel
            newMap.center = center
        } else {
            newMap.zoomLevel = (newMap.maximumZoomLevel - newMap.minimumZoomLevel)/2
        }

        newMap.forceActiveFocus();
        console.log("Supported MapType:");
        for (var i = 0; i < newMap.supportedMapTypes.length; i++) {
           console.log(i, newMap.supportedMapTypes[i].name);
        }

    }
    function changeMapCenter(lat, lon) {
        if (newMap != null) {
            newMap.center.latitude = lat; // широту
            newMap.center.longitude = lon; // долготу
        }
    }

    function changeMapType(mapTypeIndex) {
        newMap.activeMapType = newMap.supportedMapTypes[mapTypeIndex]
    }

    Rectangle {
        z: 2
        anchors.fill: rulerPopup
        anchors.margins: -10
        color: "red"
        border.color: "black"
        border.width: 5
        radius: 10
        visible: rulerPopup.visible
        opacity: 0.7
    }

    Label {
        id: rulerPopup
        font.pointSize: 12
        text: qsTr(rulerModel.checkPoint + "\n" + rulerModel.distance)
        visible: false
        z: 3
    }

    Instruments {
        id: instruments
        anchors.fill: parent
    }

    Slider {
        id: zoomSlider
        orientation: Qt.Vertical
        stepSize: 0.1
        height: parent.height * 0.5
        minimumValue: newMap.minimumZoomLevel
        maximumValue: newMap.maximumZoomLevel
        value: newMap.zoomLevel
        x: parent.width * 0.9 - width/2
        y: parent.height * 0.3
        z: 1
        onValueChanged: {
            if ((value >= 0)&&(newMap != null))
                newMap.zoomLevel = value
        }
    }

    Image {
        id: compassImg
        source: "img/icons/compass.png"
        x: parent.width * 0.9 - width/2
        y: parent.height * 0.9 - height/2
        z: 1
    }

    Image {
        id: upArrowImg
        source: "img/icons/up-arrow.svg"
        width: 32
        height: 32
        x: parent.width * 0.9 - width/2
        y: parent.height * 0.1 - height/2
        z: 1
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (newMap){
                    newMap.center.latitude += 1.0/newMap.zoomLevel;
                }
            }
        }
    }
    Image {
        id: downArrowImg
        source: "img/icons/down-arrow.svg"
        width: 32
        height: 32
        x: upArrowImg.x
        y: upArrowImg.y + 2 * upArrowImg.height
        z: 1
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (newMap){
                    newMap.center.latitude -= 1.0/newMap.zoomLevel;
                }
            }
        }
    }
    Image {
        id: leftArrowImage
        source: "img/icons/left-arrow.svg"
        width: 32
        height: 32
        x: upArrowImg.x - leftArrowImage.width
        y: (upArrowImg.y + downArrowImg.y) / 2
        z: 1
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (newMap){
                    newMap.center.longitude -= 1.0/newMap.zoomLevel;
                }
            }
        }
    }
    Image {
        id: rightArrowImage
        source: "img/icons/right-arrow.svg"
        width: 32
        height: 32
        x: upArrowImg.x + rightArrowImage.width
        y: (upArrowImg.y + downArrowImg.y) / 2
        z: 1
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (newMap){
                    newMap.center.longitude += 1.0/newMap.zoomLevel;
                }
            }
        }
    }

    OsmPlugin {
        id: osmPlugin
    }

    MapboxPlugin {
        id: mapboxPlugin
    }

    EsriPlugin {
        id: esriPlugin
    }

    HerePlugin {
        id: herePlugin
    }

    CustomPlugin {
        id: customPlugin
    }
}
