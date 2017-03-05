import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Item {
    width: 400
    height: 400

    ColumnLayout {
        TabBar {
            TabButton {
                text: qsTr("Exif")
            }

            TabButton {
                text: qsTr("Из файла")
            }
        }
    }
}
