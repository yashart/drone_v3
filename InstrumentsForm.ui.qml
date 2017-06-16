import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Item {
    property alias pointsButton: pointsButton
    property alias rulerButton: rulerButton
    property alias leftMenuButton: leftMenuButton
    property alias mouseButton: mouseButton
    property alias savePointsButton: savePointsButton
    property alias calibrateButton: calibrateButton
    property alias calibrateShowButton: calibrateShowButton
    property alias tracksMapButton: tracksMapButton

    id: instruments
    z: 1

    ToolBar {
        id: toolBar
        /*transformOrigin: Item.Center
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter*/
        height: 30

        RowLayout {
            id: rowLayout
            height: parent

            ExclusiveGroup { id: toolBarsButtonts }

            ToolButton {
                id: mouseButton
                iconSource: "qrc:/img/cursor.png"
                checkable: true
                checked: true
                exclusiveGroup : toolBarsButtonts
            }

            ToolButton {
                id: pointsButton
                iconSource: "qrc:/img/placeholder.png"
                checkable: true
                exclusiveGroup : toolBarsButtonts
            }

            ToolButton {
                id: rulerButton
                iconSource: "qrc:/img/ruler.png"
                checkable: true
                exclusiveGroup : toolBarsButtonts
            }

            ToolButton {
                id: savePointsButton
                iconSource: "qrc:/img/getmap.png"
                checkable: true
                exclusiveGroup : toolBarsButtonts
            }

            ToolButton {
                id: calibrateButton
                iconSource: "qrc:/img/georefer.png"
                checkable: true
                exclusiveGroup : toolBarsButtonts
            }

            ToolButton {
                id: leftMenuButton
                iconSource: "qrc:/img/menu.png"
                checkable: false
                exclusiveGroup : toolBarsButtonts
            }
            ToolButton {
                id: calibrateShowButton
                iconSource: "qrc:/img/calibration-mark.png"
                checkable: false
                exclusiveGroup: toolBarsButtonts
            }
            ToolButton {
                id: tracksMapButton
                iconSource: "qrc:/img/tracks-map.png"
                checkable: false
                exclusiveGroup: toolBarsButtonts
            }
        }
    }
}
