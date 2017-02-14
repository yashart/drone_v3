import QtQuick 2.4
import QtQuick.Controls 2.1

LeftTabMenuForm {

    osmRadio.onClicked: {
        changeMapPlugin("osmPlugin");
        linesModel.updateModel();
    }

    mapboxRadio.onClicked: {
        changeMapPlugin("mapboxPlugin");
        linesModel.updateModel();
    }
}
