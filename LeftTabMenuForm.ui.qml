import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

Window {
    height: 560
    width: 360
    id: leftTabMenuWindow
    title: "Работа с картами"
    property alias osmRadio: osmRadio
    property alias mapboxRadio: mapboxRadio
    property alias esriRadio: esriRadio
    property alias leftTabMenuArea: leftTabMenuArea
    property alias hereRadio: hereRadio
    property alias googleSatRadio: googleSatRadio
    property alias googleMapsRadio: googleMapsRadio
    property alias bingSatRadio: bingSatRadio
    property alias bingMapsRadio: bingMapsRadio
    property alias bingHibridRadio: bingHibridRadio
    property alias setOrthoPhoto: setOrthoPhoto

    maximumHeight: 560
    maximumWidth: 360

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
                    text: qsTr("Треки")
                    font.pointSize: 9
                }

                TabButton {
                    id: mapsTabButton
                    text: qsTr("Тип карты")
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
                                    onClicked: {
                                        if (checked == true) {
                                            pointsModel.addId(id)
                                            tracksModel.setChecked(id)
                                            linesModel.addId(id)
                                            imagePages.addTrack(id, name)
                                        }
                                        if (checked == false) {
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
                                            var lat = dataBase.getAvgLat(
                                                        trackId)
                                            var lon = dataBase.getAvgLon(
                                                        trackId)
                                            if (lat !== 0 && lon !== 0
                                                    && parent.checked == true) {
                                                mapComponent.changeMapCenter(
                                                            lat, lon)
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
                                Rectangle {
                                    color: color_track
                                    width: 32
                                    height: 32
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            changeColorTrackPopup.id = id
                                            changeColorTrackPopup.visible = true
                                        }
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
                    anchors.fill: parent
                    ScrollView {
                        id: mapTypeScroll
                        //anchors.fill: parent
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.left: parent.left
                        height: parent.height - mapPath.height
                        ColumnLayout {
                            RadioButton {
                                id: googleMapsRadio
                                checked: true
                                text: qsTr("Google Карты")
                            }
                            RadioButton {
                                id: googleSatRadio
                                text: qsTr("Google Спутник")
                            }
                            RadioButton {
                                id: bingMapsRadio
                                text: qsTr("Bing Карты")
                            }
                            RadioButton {
                                id: bingSatRadio
                                text: qsTr("Bing Спутник")
                            }
                            RadioButton {
                                id: bingHibridRadio
                                text: qsTr("Bing Гибрид")
                            }
                            RadioButton {
                                id: osmRadio
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
                    Item{
                        id: mapPath
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.left: parent.left
                        height: 100

                        Rectangle{
                            anchors.fill: parent
                            border.width:2

                            Rectangle{
                                anchors.right: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width / 2
                                CheckBox{
                                    id: setOrthoPhoto
                                    anchors.centerIn: parent
                                    text:"Показать фотопланы"
                                }
                            }
                            ColumnLayout{
                                anchors.left: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width / 2
                                Button{
                                    Layout.alignment: Qt.AlignCenter
                                    text: "Выбрать кэш"
                                }
                                Label{
                                    Layout.alignment: Qt.AlignCenter
                                    text: cacheSettings.cachePath()
                                    font.pixelSize: 10
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
