import QtQuick 2.4

LeftTabMenuForm {

    osmRadio.onClicked: {
        changeMapPlugin("osmPlugin");
    }
    mapboxRadio.onClicked: {
        changeMapPlugin("mapboxPlugin");
    }
}
