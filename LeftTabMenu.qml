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

    googleSatRadio.onClicked: {
        changeMapPlugin("customPlugin");
        mapComponent.changeMapType(0);
        linesModel.updateModel();
        pointsModel.updateModel();
    }
    googleMapsRadio.onClicked: {
        changeMapPlugin("customPlugin");
        mapComponent.changeMapType(1);
        linesModel.updateModel();
        pointsModel.updateModel();
    }
    bingMapsRadio.onClicked: {
        changeMapPlugin("customPlugin");
        mapComponent.changeMapType(2);
        linesModel.updateModel();
        pointsModel.updateModel();
    }
    bingSatRadio.onClicked: {
        changeMapPlugin("customPlugin");
        mapComponent.changeMapType(3);
        linesModel.updateModel();
        pointsModel.updateModel();
    }
    bingHibridRadio.onClicked: {
        changeMapPlugin("customPlugin");
        mapComponent.changeMapType(4);
        linesModel.updateModel();
        pointsModel.updateModel();
    }

    leftTabMenuArea.onEntered: {
        opacity = 1
    }
    leftTabMenuArea.onExited: {
        opacity = 0.75
    }

    setOrthoPhoto.onCheckedChanged: {
        if (setOrthoPhoto.checked == true){
            cacheSettings.onOrtho()
        }
        else
        {
            cacheSettings.offOrtho()
        }
    }
}
