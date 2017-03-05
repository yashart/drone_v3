import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

Window {
    property alias addTracksArea: addTracksArea

    id: addTracksForm

    height: 360
    width: 360
    opacity: 0.75
    MouseArea {
        id: addTracksArea
        anchors.fill: parent
        hoverEnabled: true

        Page {
            header: TabBar {
                id: tabBar
                TabButton {
                    text: qsTr("Exif")
                }
                TabButton {
                    text: qsTr("Из файла")
                }
            }
            StackLayout {
                id: stackLayout
                anchors.fill: parent
                currentIndex: tabBar.currentIndex

                Item {
                    ColumnLayout {
                        Button {
                            text: qsTr("Выбрать папку")
                        }
                    }
                }

                Item {
                    ColumnLayout {
                        Button {
                            text: qsTr("Папка с изображениями")
                        }
                        Button {
                            text: qsTr("Выбрать файл")
                        }
                    }
                }
            }
        }
    }
}
