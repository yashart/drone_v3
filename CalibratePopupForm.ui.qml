import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

Window {
    property alias calibrateModel: calibrateModel
    property alias calibrateView: calibrateView
    property alias clearCalibrateModelButton: clearCalibrateModelButton
    property alias calibrateButton: calibrateButton
    id: calibratePopup
    width: 360
    height: 560
    visible: true
    ColumnLayout {
        anchors.fill: parent
        TableView {
            focus: true
            id: calibrateView
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.8
            TableViewColumn {
                role: "xPos"
                title: "x"
                width: calibrateView.width * 0.25
            }
            TableViewColumn {
                role: "yPos"
                title: "y"
                width: calibrateView.width * 0.25
            }
            TableViewColumn {
                role: "lat"
                title: "lat"
                width: calibrateView.width * 0.25
            }
            TableViewColumn {
                role: "lon"
                title: "lon"
                width: calibrateView.width * 0.25
            }
            Keys.onPressed: {
                if(currentRow != -1){
                    calibrateModel.remove(currentRow)
                    if(calibrateModel.get(currentRow).xPos != -1){
                        calibrateModel.currentPhotoPoint -= 1
                    }
                    if(calibrateModel.get(currentRow).lat != -1){
                        calibrateModel.currentMapPoint -= 1
                    }
                }
            }

            model: calibrateModel
        }
        Button {
            id: calibrateButton
            text: qsTr("Калибровать")
        }
        Button {
            id: clearCalibrateModelButton
            text: qsTr("Очистить")
        }
    }
    ListModel {
        id: calibrateModel
        property var currentImage: 1
        property var currentMap: 1
        ListElement {
            xPos: 5
            yPos: 6
            lat: 18.5
            lon: -22.5
        }
    }
}
