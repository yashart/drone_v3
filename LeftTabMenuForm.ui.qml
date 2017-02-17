import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Page {
    property alias osmRadio: osmRadio
    property alias mapboxRadio: mapboxRadio
    property alias pokemonsRadioGroup: pokemonsRadioGroup

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
                    delegate: CheckBox {
                        text: qsTr(name)
                        property var trackId: id
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
                        source: "/img/popupIconsSet/1.png"
                    }
                }
                RowLayout{
                    RadioButton {
                        checked: true
                        property var name: "2"
                        ButtonGroup.group: pokemonsRadioGroup
                    }
                    Image{
                        source: "/img/popupIconsSet/2.png"
                    }
                }
                RowLayout{
                    RadioButton {
                        checked: true
                        property var name: "3"
                        ButtonGroup.group: pokemonsRadioGroup
                    }
                    Image{
                        source: "/img/popupIconsSet/3.png"
                    }
                }
                RowLayout{
                    RadioButton {
                        checked: true
                        property var name: "4"
                        ButtonGroup.group: pokemonsRadioGroup
                    }
                    Image{
                        source: "/img/popupIconsSet/4.png"
                    }
                }
            }
        }
    }
}
