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
        mapComponent.changeMapType(0);
        linesModel.updateModel();
        pointsModel.updateModel();
    }

    esriRadio.onClicked: {
        changeMapPlugin("esriPlugin");
        mapComponent.changeMapType(1);
        linesModel.updateModel();
        pointsModel.updateModel();
    }

    hereRadio.onClicked: {
        changeMapPlugin("herePlugin");
        mapComponent.changeMapType(1);
        linesModel.updateModel();
        pointsModel.updateModel();

    }

    googleRadio.onClicked: {
        changeMapPlugin("customPlugin");
        mapComponent.changeMapType(1);
        linesModel.updateModel();
        pointsModel.updateModel();
    }
    yandexRadio.onClicked: {
        changeMapPlugin("customPlugin");
        mapComponent.changeMapType(4);
        linesModel.updateModel();
        pointsModel.updateModel();
    }
    offlineGoogleRadio.onClicked: {
        changeMapPlugin("customPlugin");
        mapComponent.changeMapType(5);
        linesModel.updateModel();
        pointsModel.updateModel();
    }
    offlinePhotoplan.onClicked: {
        changeMapPlugin("customPlugin");
        mapComponent.changeMapType(6);
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
