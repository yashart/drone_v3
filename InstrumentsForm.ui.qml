import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    property alias pointsButton: pointsButton
    property alias rulerButton: rulerButton
    id: instruments
    z: 1

    ToolBar {
        id: toolBar
        transformOrigin: Item.Center
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter

        RowLayout {
            id: rowLayout

            ToolButton {
                id: mouseButton
                text: qsTr("Мышь")
                autoExclusive: true
                checkable: true
                checked: true
            }

            ToolButton {
                id: pointsButton
                text: qsTr("Отметки")
                autoExclusive: true
                checkable: true
            }

            ToolButton {
                id: rulerButton
                text: qsTr("Линейка")
                autoExclusive: true
                checkable: true
            }

            ToolButton {
                id: angleButton
                text: qsTr("Уголок")
                checkable: true
                autoExclusive: true
            }

            ToolButton {
                id: removeButton
                text: qsTr("Корзина")
                checkable: true
                autoExclusive: true
            }
        }
    }
}
