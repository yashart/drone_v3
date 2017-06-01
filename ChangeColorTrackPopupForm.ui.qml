import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Window 2.0

Window {
    id: changeColorTrackPopupForm
    width: 200
    height: 200
    visible: true
    title: qsTr("Смена цвета")

    property alias redColorChoose: redColorChoose
    property alias blueColorChoose: blueColorChoose
    property alias greenColorChoose: greenColorChoose
    property alias magentaColorChoose: magentaColorChoose
    property alias yellowColorChoose: yellowColorChoose
    property alias grayColorChoose: grayColorChoose
    property alias cyanColorChoose: cyanColorChoose
    property alias whiteColorChoose: whiteColorChoose
    property alias blackColorChoose: blackColorChoose


    GridLayout {
        columns: 3
        Rectangle {
            color: "red"
            width: 64
            height: 64
            border.color: "black"
            border.width: 2
            MouseArea {
                id: redColorChoose
                anchors.fill: parent
            }
        }
        Rectangle {
            color: "blue"
            width: 64
            height: 64
            border.color: "black"
            border.width: 2
            MouseArea {
                id: blueColorChoose
                anchors.fill: parent
            }
        }
        Rectangle {
            color: "green"
            width: 64
            height: 64
            border.color: "black"
            border.width: 2
            MouseArea {
                id: greenColorChoose
                anchors.fill: parent
            }
        }
        Rectangle {
            color: "magenta"
            width: 64
            height: 64
            border.color: "black"
            border.width: 2
            MouseArea {
                id: magentaColorChoose
                anchors.fill: parent
            }
        }
        Rectangle {
            color: "yellow"
            width: 64
            height: 64
            MouseArea {
                id: yellowColorChoose
                anchors.fill: parent
            }
        }
        Rectangle {
            color: "gray"
            width: 64
            height: 64
            border.color: "black"
            border.width: 2
            MouseArea {
                id: grayColorChoose
                anchors.fill: parent
            }
        }
        Rectangle {
            color: "cyan"
            width: 64
            height: 64
            border.color: "black"
            border.width: 2
            MouseArea {
                id: cyanColorChoose
                anchors.fill: parent
            }
        }
        Rectangle {
            color: "white"
            width: 64
            height: 64
            border.color: "black"
            border.width: 2
            MouseArea {
                id: whiteColorChoose
                anchors.fill: parent
            }
        }
        Rectangle {
            color: "black"
            width: 64
            height: 64
            border.color: "black"
            border.width: 2
            MouseArea {
                id: blackColorChoose
                anchors.fill: parent
            }
        }
    }
}
