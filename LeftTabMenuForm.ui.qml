import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

Window {
    height: 360
    width: 360
    id: leftTabMenuWindow
    property alias osmRadio: osmRadio
    property alias mapboxRadio: mapboxRadio
    property alias pokemonsRadioGroup: pokemonsRadioGroup
    property alias leftTabMenuArea: leftTabMenuArea
    visible: parent.visible
    opacity: 0.75

    MouseArea {
        id: leftTabMenuArea
        anchors.fill: parent
        hoverEnabled: true

        Page {
            id: leftTabMenu

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

                TabButton {
                    id: pointsTabButton
                    text: qsTr("Points")
                    font.pointSize: 9
                }
            }

            StackLayout {
                id: stackLayout
                anchors.fill: parent
                currentIndex: tabBar.currentIndex

                Item {
                    id: tracksTab

                    Column {
                        Repeater {
                            id: tracksView
                            model: tracksModel
                            delegate: CheckBox{
                                property int trackId: id
                                text: qsTr(name)
                                checked: (is_check === "true") ? true : false
                                onClicked:{
                                        if (checked == true){
                                            pointsModel.addId(id);
                                            tracksModel.setChecked(id);
                                            linesModel.addId(id);
                                        }
                                        if (checked == false){
                                            pointsModel.delId(id);
                                            tracksModel.setUnchecked(id);
                                            linesModel.delId(id);
                                        }
                                        pointsModel.updateModel();
                                        tracksModel.updateModel();
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
                        }
                    }
                }

                Item {
                    id: mapPluginTab

                    ColumnLayout {
                        RadioButton {
                            id: osmRadio
                            checked: true
                            text: qsTr("Osm")
                        }

                        RadioButton {
                            id: mapboxRadio
                            text: qsTr("Mapbox")
                        }
                    }
                }

                Item {
                    id: pokemonsTab
                    ButtonGroup {
                        id: pokemonsRadioGroup
                    }

                    ColumnLayout {
                        RowLayout{
                            RadioButton {
                                checked: true
                                property var name: "1"
                                ButtonGroup.group: pokemonsRadioGroup
                            }
                            Image{
                                source: "image://Icons/triangle/black"
                            }
                        }
                        RowLayout{
                            RadioButton {
                                checked: true
                                property var name: "2"
                                ButtonGroup.group: pokemonsRadioGroup
                            }
                            Image{
                                source: "image://Icons/triangle/red"
                            }
                        }
                        RowLayout{
                            RadioButton {
                                checked: true
                                property var name: "3"
                                ButtonGroup.group: pokemonsRadioGroup
                            }
                            Image{
                                source: "image://Icons/triangle/green"
                            }
                        }
                        RowLayout{
                            RadioButton {
                                checked: true
                                property var name: "4"
                                ButtonGroup.group: pokemonsRadioGroup
                            }
                            Image{
                                source: "image://Icons/triangle/yellow"
                            }
                        }
                    }
                }
            }
        }
    }
}
