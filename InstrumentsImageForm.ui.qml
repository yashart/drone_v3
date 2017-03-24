import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Item {
    id: instrumentsImage
    anchors.horizontalCenterOffset: 0
    anchors.horizontalCenter: parent.horizontalCenter

    property alias hideButtonImage: hideButtonImage

    ToolBar {
        id: toolBar
        transformOrigin: Item.Center
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        RowLayout {
            ToolButton {
                id: mouseButtonImage
                text: qsTr("Мышь")
                autoExclusive: true
                checkable: true
                checked: true
            }

            ToolButton {
                id: pointsButtonImage
                text: qsTr("Отметки")
                checkable: true
                autoExclusive: true
            }

            ToolButton {
                id: moveButtonImage
                text: qsTr("Переставить")
                checkable: true
                autoExclusive: true
            }

            ToolButton {
                id: hideButtonImage
                text: qsTr("Скрыть информацию")
            }
        }
    }
}
