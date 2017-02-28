import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0

Item {
    id: mainPage
    property alias leftTabMenu: leftTabMenu
    signal changeMapPlugin(variant map_name);
    onChangeMapPlugin: {
        if(map_name == "osmPlugin"){
            mapComponent.createMap(mapComponent.osmPlugin);
        }
        if(map_name == "mapboxPlugin"){
            mapComponent.createMap(mapComponent.mapboxPlugin);
        }
    }

    LeftTabMenu{
        id: leftTabMenu
        visible: false
    }
    MapComponent{
        id: mapComponent
        anchors.fill: parent
    }
}
