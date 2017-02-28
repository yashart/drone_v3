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

    LoginPage {
        id: loginPage
        anchors.fill: parent
    }

    MainPage {
        anchors.fill: parent
        id: mainPage
        visible: false
    }

    ImagePage {
        id: imagePage
        visible: false
    }

    PopupPoints {
        id: popupPoints
        visible: false
    }

}
