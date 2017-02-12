import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Полигон Ф")
    menuBar: mainMenu

    MainMenu {
        id: mainMenu
    }

    MainPage {
        anchors.fill: parent
        id: mainPage
    }


    /*
    Instruments {
        id: instruments
    }
    */
    /*
    LeftTabMenu {
        id: leftTabMenu
    }*/
    /*
    OsmPlugin {
        id: osmPlugin
    }
    /*
    MapComponent {
        id: mapComponent
    }
    */

}
