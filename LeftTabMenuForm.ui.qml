import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

Window {
    height: 560
    width: 360
    id: leftTabMenuWindow
    property alias osmRadio: osmRadio
    property alias mapboxRadio: mapboxRadio
    property alias esriRadio: esriRadio
    property alias leftTabMenuArea: leftTabMenuArea
    property alias hereRadio: hereRadio
    property alias googleRadio: googleRadio
    property alias yandexRadio: yandexRadio
    property alias offlineGoogleRadio: offlineGoogleRadio

    visible: parent.visible
    opacity: 0.75

    MouseArea {
        id: leftTabMenuArea
        anchors.fill: parent
        hoverEnabled: true

        Page {
            id: leftTabMenu
            anchors.fill: parent

            header: TabBar {
                id: tabBar
                width: leftTabMenu.width

                TabButton {
                    id: tracksTabButton
                    text: qsTr("Tracks")
                    font.pointSize: 9
                }

                TabButton {
                    id: mapsTabButton
                    text: qsTr("Maps")
                    font.pointSize: 9
                }
            }

            StackLayout {
                id: stackLayout
                anchors.fill: parent
                currentIndex: tabBar.currentIndex

                ScrollView {
                    id: tracksTab
                    anchors.fill: parent

                    Column {
                        //anchors.fill: parent
                        Repeater {
                            id: tracksView
                            model: tracksModel
                            delegate: RowLayout {
                                property int trackId: id
                                CheckBox {
                                    text: qsTr(name)
                                    checked: (is_check === "true") ? true : false
                                    onClicked:{
                                        if (checked == true){
                                            pointsModel.addId(id)
                                            tracksModel.setChecked(id)
                                            linesModel.addId(id)
                                            imagePages.addTrack(id, name)
                                        }
                                        if (checked == false){
                                            pointsModel.delId(id)
                                            tracksModel.setUnchecked(id)
                                            linesModel.delId(id)
                                            imagePages.removeTrack(id)
                                        }
                                        pointsModel.updateModel()
                                        tracksModel.updateModel()
                                    }
                                    MouseArea {
                                        anchors.fill: parent
                                        acceptedButtons: Qt.RightButton
                                        onClicked: {
                                            var lat = dataBase.getAvgLat(trackId)
                                            var lon = dataBase.getAvgLon(trackId)
                                            if (lat !== 0 && lon !== 0 && parent.checked == true)
                                            {
                                                mapComponent.changeMapCenter(lat, lon)
                                            }
                                        }
                                    }
                                }
                                Button {
                                    id: deleteTrackButton
                                    text: qsTr("Удалить")
                                    onClicked: {
                                        dataBase.deleteTrack(id)
                                    }
                                }
                            }
                        }
                        Button {
                            text: qsTr("Добавить")
                            onClicked: {
                                addTracks.visible = true
                            }
                        }
                        Button {
                            text: qsTr("Удалить")
                        }
                        Button {
                            text: qsTr("Редактировать")
                        }
                    }
                }

                Item {
                    id: mapPluginTab
                    ScrollView {
                        anchors.fill: parent
                        ColumnLayout {

                            RadioButton {
                                id: googleRadio
                                text: qsTr("Google Maps")
                            }
                            RadioButton {
                                id: yandexRadio
                                text: qsTr("Yandex Maps")
                            }
                            RadioButton {
                                id: offlineGoogleRadio
                                text: qsTr("Offline Google Maps")
                            }
                            RadioButton {
                                id: osmRadio
                                checked: true
                                text: qsTr("Osm")
                            }
                            RadioButton {
                                id: mapboxRadio
                                text: qsTr("Mapbox")
                            }
                            RadioButton {
                                id: esriRadio
                                text: qsTr("Esri")
                            }
                            RadioButton {
                                id: hereRadio
                                text: qsTr("Here")
                            }
                        }
                    }
                }
            }
        }
    }
}
