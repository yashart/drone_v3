import QtQuick 2.0
import QtLocation 5.6
import QtPositioning 5.3
import QtQuick.Controls 1.4

Item {
    id: mapComponent
    property alias osmPlugin: osmPlugin
    property alias mapboxPlugin: mapboxPlugin
    property var newMap: null;
    function createMap(plugin){
        var zoomLevel = null;
        var center = null;
        if (newMap) {
            zoomLevel = newMap.zoomLevel;
            center = newMap.center;
            newMap.destroy();
        }
        newMap = Qt.createQmlObject("
            import QtQuick 2.0
            import QtLocation 5.3
            import QtPositioning 5.3

            Map {
                id: map
                anchors.fill: parent
            }
            ", mapComponent);
        console.log(newMap);
        newMap.plugin = plugin;

        if (zoomLevel != null) {
            newMap.zoomLevel = zoomLevel
            newMap.center = center
        } else {
            newMap.zoomLevel = (newMap.maximumZoomLevel - newMap.minimumZoomLevel)/2
        }

        newMap.forceActiveFocus();

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
        x: parent.width * 0.9
        y: parent.width * 0.3
        z: 1
        onValueChanged: {
            if ((value >= 0)&&(newMap != null))
                newMap.zoomLevel = value
        }
    }

    OsmPlugin {
        id: osmPlugin
    }

    MapboxPlugin {
        id: mapboxPlugin
    }
}
