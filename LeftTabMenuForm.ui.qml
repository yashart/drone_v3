import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Page {
    property alias osmRadio: osmRadio
    property alias mapboxRadio: mapboxRadio

    id: leftTabMenu

    header: TabBar {
        id: tabBar
        width: leftTabMenu.width

        TabButton {
            id: tracksTabButton
            text: qsTr("Tracks")
        }

        TabButton {
            id: mapsTabButton
            text: qsTr("Maps")
        }
    }

    StackLayout {
        id: stackLayout
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Item {
            id: tracksTab

            ColumnLayout {
                RadioButton {
                    checked: true
                    text: qsTr("Фурмановка")
                }

                RadioButton {
                    text: qsTr("Тихорецк")
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
    }
}
