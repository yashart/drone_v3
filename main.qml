import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.0

ApplicationWindow {
    visible: true
    visibility: "Maximized"
    minimumWidth: 600
    minimumHeight: 400
    title: qsTr("Полигон Ф")
    menuBar: mainMenu

    MainMenu {
        id: mainMenu
    }

    LoginPage {
        id: loginPage
        anchors.fill: parent
    }

    MainPage {
        anchors.fill: parent
        id: mainPage
        visible: false
    }

    /*
    ImagePage {
        id: imagePage
        visible: false
    }
    */
    ImagePageModel {
        id: imagePages
    }

    PopupPoints {
        id: popupPoints
        visible: false
    }

    AddTracks {
        id: addTracks
        visible: false
    }

    VideoWindows {
        id: videoPage
        visible: false
    }

    CalibratePopup {
        id: calibratePopup
        visible: true
    }
    ExportFileDialog{
        id: exportFileDialog
    }
}
