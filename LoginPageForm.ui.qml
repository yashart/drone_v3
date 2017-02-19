import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Item {
    property alias loginTextField: loginTextField
    property alias passwordTextField: passwordTextField
    property alias loginButton: loginButton

    anchors.fill: parent
    ColumnLayout {
        anchors.fill: parent
        id: gridLayout

        Label {
            text: qsTr("Авторизация")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            Layout.column: 1
            Layout.row: 0
            font.family: "Times New Roman"
            font.pointSize: 15
        }
        RowLayout {
            spacing: 25
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                text: qsTr("Логин")
                font.weight: Font.ExtraLight
                font.family: "Times New Roman"
                font.pointSize: 15
            }
            TextField {
                id: loginTextField
            }
        }
        RowLayout {
            spacing: 25
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                text: qsTr("Пароль")
                font.pointSize: 14
            }
            TextField {
                id: passwordTextField
                echoMode: TextInput.Password
            }
        }
        Button {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: qsTr("Войти");
            id: loginButton
        }
    }
}
