import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4

Item {
    id: instrumentsImage
    anchors.horizontalCenterOffset: 0
    anchors.horizontalCenter: parent.left

    property alias hideButtonImage: hideButtonImage
    property alias pointsButtonImage: pointsButtonImage
    property alias calibrateButtonImage: calibrateButtonImage
    property alias gridButtonImage: gridButtonImage
    property alias calibrateShowButtonImage: calibrateShowButtonImage

    ToolBar {
        id: toolBar
        /*transformOrigin: Item.Center
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter*/
        height: 30



        RowLayout {
            ExclusiveGroup { id: toolBarsButtonts }
            ToolButton {
                id: mouseButtonImage
                iconSource: "qrc:/img/cursor.png"
                exclusiveGroup: toolBarsButtonts
                checkable: true
                checked: true
            }

            ToolButton {
                id: pointsButtonImage
                iconSource: "qrc:/img/placeholder.png"
                checkable: true
                exclusiveGroup: toolBarsButtonts
            }

            ToolButton {
                id: hideButtonImage
                iconSource: "qrc:/img/menu.png"
            }

            ToolButton {
                id: calibrateButtonImage
                iconSource: "qrc:/img/georefer.png"
                checkable: true
                exclusiveGroup: toolBarsButtonts
            }

            ToolButton {
                id: gridButtonImage
                iconSource: "qrc:/img/grid.png"
                checkable: true
                exclusiveGroup: toolBarsButtonts
            }

            ToolButton {
                id: calibrateShowButtonImage
                iconSource: "qrc:/img/calibration-mark.png"
                checkable: true
                exclusiveGroup: toolBarsButtonts
            }
        }
    }
}
