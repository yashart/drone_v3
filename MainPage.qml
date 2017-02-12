import QtQuick 2.4
import QtQuick.Layouts 1.3

Item {
    id: mainPage
    signal changeMapPlugin(variant map_name);
    onChangeMapPlugin: {
        if(map_name == "osmPlugin"){
            mapComponent.createMap(mapComponent.osmPlugin);
        }
        if(map_name == "mapboxPlugin"){
            mapComponent.createMap(mapComponent.mapboxPlugin);
        }
    }

    RowLayout{
        LeftTabMenu{
            id: leftTabMenu
            Layout.preferredWidth: mainPage.width * 0.3
            Layout.preferredHeight: mainPage.height
        }
        MapComponent{
            id: mapComponent
            Layout.preferredWidth: mainPage.width * 0.7
            Layout.preferredHeight: mainPage.height
        }
    }
}
