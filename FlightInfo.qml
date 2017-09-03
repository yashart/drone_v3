import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

Window {
    id: flightInfo
    height: 400
    width: 400
    visible: true
    title: qsTr("Коптер инфо")
    Timer {
        interval: 500; running: true; repeat: true
        onTriggered: {
            telemetry.readAxes()
            console.log(telemetry.pitch,
                        telemetry.row,
                        telemetry.yaw)
        }
    }
    ColumnLayout {
        anchors.fill: parent
        Image {
            source: "img/yaw.png"
            rotation: telemetry.yaw
        }
        Image {
            source: "img/pitch.png"
            rotation: telemetry.pitch
        }
        Image {
            source: "img/roll.png"
            rotation: telemetry.row
        }
        Label {
            text: "Рысканье: " + telemetry.yaw
        }
        Label {
            text: "Тангаж: " + telemetry.pitch
        }
        Label {
            text: "Крен: " + telemetry.row
        }
    }
}
