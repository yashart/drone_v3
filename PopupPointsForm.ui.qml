import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Window 2.2

Window {
    property alias popupPointsArea: popupPointsArea

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
                    text: qsTr("")
                }

                Label {
                    text: qsTr("Долгота")
                }

                TextField {
                    text: qsTr("")
                }
            }

            GridLayout {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                rows: 0
                columns: 0
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                GridLayout {
                }

                Label {
                    text: qsTr("Выбор цвета")
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
                        text: qsTr("Отмена")
                    }
                }
            }
        }
    }
}
