import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.0 as C2
import QtQuick.Layouts 1.3

Row {
    id: containerRow

    property var mapSource
    property real fontSize : 14
    property color labelBackground : "transparent"
    property int edge: Qt.RightEdge
    property alias expanded: sliderToggler.checked

    function rightEdge() {
        return (containerRow.edge === Qt.RightEdge);
    }

    layoutDirection: rightEdge() ? Qt.LeftToRight : Qt.RightToLeft
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.right: rightEdge() ? parent.right : undefined
    anchors.left: rightEdge() ? undefined : parent.left


    Button {
        id: sliderToggler
        width: 32
        height: 96
        checkable: true
        checked: false
        anchors.verticalCenter: parent.verticalCenter

        transform:  Scale {
                        origin.x: rightEdge() ? 0 : sliderToggler.width / 2
                        xScale: rightEdge() ? 1 : -1
                    }

        style:  ButtonStyle {
                    background: Rectangle {
                        color: "transparent"
                    }
                }

        property real shear: 0.333
        property real buttonOpacity: 0.5
        property real mirror : rightEdge() ? 1.0 : -1.0

        Rectangle {
            width: 16
            height: 48
            color: "red"
            antialiasing: true
            opacity: sliderToggler.buttonOpacity
            anchors.top: parent.top
            anchors.left: sliderToggler.checked ?  parent.left : parent.horizontalCenter
            transform: Matrix4x4 {
                property real d : sliderToggler.checked ? 1.0 : -1.0
                matrix:    Qt.matrix4x4(1.0,  d * sliderToggler.shear,    0.0,    0.0,
                                        0.0,    1.0,    0.0,    0.0,
                                        0.0,    0.0,    1.0,    0.0,
                                        0.0,    0.0,    0.0,    1.0)
            }
        }

        Rectangle {
            width: 16
            height: 48
            color: "red"
            antialiasing: true
            opacity: sliderToggler.buttonOpacity
            anchors.top: parent.verticalCenter
            anchors.right: sliderToggler.checked ?  parent.right : parent.horizontalCenter
            transform: Matrix4x4 {
                property real d : sliderToggler.checked ? -1.0 : 1.0
                matrix:    Qt.matrix4x4(1.0,  d * sliderToggler.shear,    0.0,    0.0,
                                        0.0,    1.0,    0.0,    0.0,
                                        0.0,    0.0,    1.0,    0.0,
                                        0.0,    0.0,    0.0,    1.0)
            }
        }
    }

    Rectangle {
        id: sliderContainer
        height: parent.height
        width: sliderRow.width + 10
        visible: sliderToggler.checked
        color: Qt.rgba( 1, 1, 1, 0.6)

        property var labelBorderColor: "transparent"
        property var slidersHeight : sliderContainer.height
                                     - rowSliderValues.height
                                     - rowSliderLabels.height
                                     - sliderColumn.spacing * 2
                                     - sliderColumn.topPadding
                                     - sliderColumn.bottomPadding

        Column {
            id: sliderColumn
            spacing: 10
            topPadding: 16
            bottomPadding: 48
            anchors.centerIn: parent

            // The sliders row
            Column {
                spacing: -10
                topPadding: 30
                id: sliderRow
                //height: mapSource.height
                width:150

                Column {
                    width: parent.width
                    bottomPadding: 30
                    Text{
                        text : "Яркость"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    C2.Slider {
                        id: brightnessSlider
                        width: parent.width
                        orientation : Qt.Horizontal
                        from : -200
                        to : 200
                        stepSize: 1
                        value : 0
                        onValueChanged: {
                            if (value != 0){
                                bSave.enabled = true
                                bCancel.enabled = true
                            }

                            currentPhoto.source = "image://photo/" +
                                currentPhoto.dir +
                                currentPhoto.name + "?" + "temp=true&brightness=" +
                                brightnessSlider.value
                        }
                    }
                    RowLayout{
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button{
                            id:bSave
                            text: "Применить"
                            enabled: false
                            onClicked: {
                                currentPhoto.source = "image://photo/" +
                                    currentPhoto.dir +
                                    currentPhoto.name + "?" + "save=true&brightness=" +
                                    brightnessSlider.value

                                bSave.enabled = false
                                bCancel.enabled = false
                                brightnessSlider.value = 0
                            }
                        }
                        Button{
                            id:bCancel
                            text: "Отменить"
                            enabled: false
                            onClicked: {
                                bSave.enabled = false
                                bCancel.enabled = false
                                brightnessSlider.value = 0
                            }
                        }
                    }


                }

                Column {
                    width: parent.width
                    bottomPadding: 30
                    Text{
                        text : "Контраст"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    C2.Slider {
                        id: contrastSlider
                        width: parent.width
                        from: 0
                        to: 2
                        stepSize: 0.05
                        orientation : Qt.Horizontal
                        value: 1
                        onValueChanged: {

                            if (value != 1){
                                cSave.enabled = true
                                cCancel.enabled = true
                            }

                            currentPhoto.source = "image://photo/" +
                                currentPhoto.dir +
                                currentPhoto.name + "?" + "temp=true&contrast=" +
                                Math.round(contrastSlider.value * 100) / 100
                        }
                    }
                    RowLayout{
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button{
                            id:cSave
                            text: "Применить"
                            enabled: false
                            onClicked: {
                                currentPhoto.source = "image://photo/" +
                                    currentPhoto.dir +
                                    currentPhoto.name + "?" + "save=true&contrast=" +
                                    Math.round(contrastSlider.value * 100) / 100

                                cSave.enabled = false
                                cCancel.enabled = false
                                contrastSlider.value = 1
                            }
                        }
                        Button{
                            id:cCancel
                            text: "Отменить"
                            enabled: false
                            onClicked: {
                                cSave.enabled = false
                                cCancel.enabled = false
                                contrastSlider.value = 1
                            }
                        }
                    }
                }

                Column {
                    width: parent.width
                    bottomPadding: 30
                    Text{
                        text : "Гамма"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    C2.Slider {
                        id: gammaSlider
                        width: parent.width
                        orientation : Qt.Horizontal
                        from: 0.1
                        to: 2
                        stepSize: 0.05
                        value: 1
                        onValueChanged: {
                            if (value != 1){
                                gSave.enabled = true
                                gCancel.enabled = true
                            }
                            currentPhoto.source = "image://photo/" +
                                currentPhoto.dir +
                                currentPhoto.name + "?" + "temp=true&gamma=" +
                                Math.round(gammaSlider.value * 100) / 100
                        }
                    }
                    RowLayout{
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button{
                            id:gSave
                            text: "Применить"
                            enabled: false
                            onClicked: {
                                currentPhoto.source = "image://photo/" +
                                    currentPhoto.dir +
                                    currentPhoto.name + "?" + "save=true&gamma=" +
                                    Math.round(gammaSlider.value * 100) / 100

                                gSave.enabled = false
                                gCancel.enabled = false
                                gammaSlider.value = 1
                            }
                        }
                        Button{
                            id:gCancel
                            text: "Отменить"
                            enabled: false
                            onClicked: {
                                gSave.enabled = false
                                gCancel.enabled = false
                                gammaSlider.value = 1
                            }
                        }
                    }
                }
                RowLayout{
                    anchors.horizontalCenter: parent.horizontalCenter
                    Button {
                        text:"Инвертировать"
                        onClicked: {
                            currentPhoto.source = "image://photo/" +
                                    currentPhoto.dir +
                                    currentPhoto.name +  "?" + "invert=true"
                        }
                    }
                    Button {
                        text: "Cтандартное"
                        onClicked: {
                            currentPhoto.source = "image://photo/" +
                                    currentPhoto.dir +
                                    currentPhoto.name + "?" + "standart=true"
                        }
                    }
                }

            } // Row sliders
        } // Column
    } // sliderContainer
} // containerRow
