import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Window 2.2

Window {
    property alias popupPointsArea: popupPointsArea
    property alias popupPointsForm: popupPointsForm
    property alias redRadioButton: redRadioButton
    property alias greenRadioButton: greenRadioButton
    property alias blackRadioButton: blackRadioButton
    property alias yellowRadioButton: yellowRadioButton
    property alias triangleRadioButton: triangleRadioButton
    property alias squareRadioButton: squareRadioButton
    property alias questionRadioButton: questionRadioButton
    property alias submitPopupButton: submitPopupButton
    property alias deletePointPopupButton: deletePointPopupButton

    property var latitude: 0
    property var longitude: 0
    property var iconColor: "red"
    property var iconType: "triangle"
    property var pointId: 0

    id: popupPointsForm
    height: 500
    width: 500
    visible: parent.visible
    opacity: 0.75
    MouseArea {
        id: popupPointsArea
        anchors.fill: parent
        hoverEnabled: true

        ColumnLayout {
            anchors.fill: parent
            RowLayout {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Label {
                    text: qsTr("Широта")
                }

                TextField {
                    text: qsTr(String(popupPointsForm.latitude))
                }

                Label {
                    text: qsTr("Долгота")
                }

                TextField {
                    text: qsTr(String(popupPointsForm.longitude))
                }
            }
            GridLayout {
                columns: 3
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                RadioButton {
                    id: triangleRadioButton
                    Image {
                        anchors.fill: parent
                        source: "image://Icons/triangle/" + popupPointsForm.iconColor
                    }
                    checkable: true
                    checked: true
                }
                RadioButton {
                    id: squareRadioButton
                    Image {
                        anchors.fill: parent
                        source: "image://Icons/square/" + popupPointsForm.iconColor
                    }
                    checkable: true
                }
                RadioButton {
                    id: questionRadioButton
                    Image {
                        anchors.fill: parent
                        source: "image://Icons/question/" + popupPointsForm.iconColor
                    }
                    checkable: true
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                GridLayout {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    columns: 4

                    Rectangle {
                        id: redRectangle
                        width: 50
                        height: 50
                        color: "red"
                        border.color: "black"
                        border.width: 2
                        radius: 5
                    }
                    Rectangle {
                        id: greenRectangle
                        width: 50
                        height: 50
                        color: "green"
                        border.color: "black"
                        border.width: 2
                        radius: 5
                    }
                    Rectangle {
                        id: blackRectangle
                        width: 50
                        height: 50
                        color: "black"
                        border.color: "black"
                        border.width: 2
                        radius: 5
                    }
                    Rectangle {
                        id: yellowRectangle
                        width: 50
                        height: 50
                        color: "yellow"
                        border.color: "black"
                        border.width: 2
                        radius: 5
                    }

                    RadioButton {
                        id: redRadioButton
                        checked: true
                    }
                    RadioButton {
                        id: greenRadioButton
                    }
                    RadioButton {
                        id: blackRadioButton
                    }
                    RadioButton {
                        id: yellowRadioButton
                    }
                }
            }

            Label {
                text: qsTr("Изменить положение")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                ColumnLayout {

                    Label {
                        text: qsTr("По горизонтали")
                    }

                    TextField {
                        text: qsTr("")
                    }

                    Button {
                        id: submitPopupButton
                        text: qsTr("Ок")
                    }
                }

                ColumnLayout {

                    Label {
                        text: qsTr("По вертикали")
                    }

                    TextField {
                        text: qsTr("")
                    }

                    Button {
                        id: deletePointPopupButton
                        text: qsTr("Удалить")
                    }
                }
            }
        }
    }
}
