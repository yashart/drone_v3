import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

Window {
    id: addTracksForm
    height: 360
    width: 360
    MouseArea {
        id: addTracksArea
        anchors.fill: parent
        hoverEnabled: true

            StackLayout {
                id: stackLayout
                anchors.fill: parent
                currentIndex: tabBar.currentIndex

                Item {
                    ColumnLayout {
                        Button {
                            text: qsTr("Выбрать папку c exif")
                            onClicked: {
                                getParseFileDialog.open();
                            }
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

    FileDialog {
        id: getParseFileDialog
        title: "Выберите папку"
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            var str = folder
            dataBase.addExifDir(folder, folder);
        }
        onRejected: {
            console.log("Canceled");
        }
    }
}
