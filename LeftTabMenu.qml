import QtQuick 2.4
import QtQuick.Controls 2.1

LeftTabMenuForm {
    visible: false
    osmRadio.onClicked: {
        changeMapPlugin("osmPlugin");
        linesModel.updateModel();
        pointsModel.updateModel();
    }

    mapboxRadio.onClicked: {
        changeMapPlugin("mapboxPlugin");
        linesModel.updateModel();
        pointsModel.updateModel();
    }
    leftTabMenuArea.onEntered: {
        opacity = 1
    }
    leftTabMenuArea.onExited: {
        opacity = 0.75
    }
}
