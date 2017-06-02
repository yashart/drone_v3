import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

Window {
    id: imagePage
    property alias currentPhoto: currentPhoto
    property alias dragAreaPhoto: dragAreaPhoto
    property alias gridNorth: gridNorth
    property alias gridPicture: gridPicture

    property alias pictureViewer: pictureViewer
    property alias pictureViewerArea: pictureViewerArea
    property alias photoInformation: photoInformation
    property alias instrumentsImage: instrumentsImage

    property alias standartImageRadio: standartImageRadio
    property alias invertImageRadio: invertImageRadio
    property alias colorizeImageRadio: colorizeImageRadio
    property alias brightnessImageRadio: brightnessImageRadio
    property alias gammaImageRadio: gammaImageRadio
    property alias desaturateImageRadio: desaturateImageRadio
    property alias hueImageRadio: hueImageRadio

    property alias channelRed: channelRed
    property alias channelGreen: channelGreen
    property alias channelBlue: channelBlue

    property alias contrastSlider: contrastSlider
    property alias brightnessSlider: brightnessSlider
    property alias colorizeSlider: colorizeSlider
    property alias gammaSlider: gammaSlider
    property alias desaturateSlider: desaturateSlider
    property alias hueSlider: hueSlider
    property alias transformImage: transformImage


    height: 392
    width: 360

    RowLayout {
        anchors.fill: parent
        Window {
            color: "#E0E0E0"
            id: photoInformation
            width: 500
            height: 560
            visible: imagePage.visible
            ColumnLayout {
                anchors.fill: parent
                ExclusiveGroup { id: imagePropertyGroup }

                RadioButton {
                    id: standartImageRadio
                    checked: true
                    exclusiveGroup: imagePropertyGroup
                    text: qsTr("Обычное")
                }

                RadioButton {
                    id: invertImageRadio
                    exclusiveGroup: imagePropertyGroup
                    text: qsTr("Инвертированное")
                }

                RadioButton {
                    id: contrastImageRadio
                    exclusiveGroup: imagePropertyGroup
                    text: qsTr("Контраст")
                }
                Slider {
                    id: contrastSlider
                    maximumValue: 3
                    minimumValue: 0
                    stepSize: 0.10
                    value: 1
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width * 0.8
                }

                RadioButton {
                    id: brightnessImageRadio
                    exclusiveGroup: imagePropertyGroup
                    text: qsTr("Яркость")
                }
                Slider {
                    id: brightnessSlider
                    maximumValue: 1
                    minimumValue: -1
                    stepSize: 0.05
                    value: 0
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width * 0.8
                }

                RadioButton {
                    id: colorizeImageRadio
                    exclusiveGroup: imagePropertyGroup
                    text: qsTr("Цветовой тон")
                }
                Slider {
                    id: colorizeSlider
                    maximumValue: 1
                    minimumValue: 0
                    stepSize: 0.01
                    value: 0
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width * 0.8
                }


                RadioButton {
                    id: gammaImageRadio
                    exclusiveGroup: imagePropertyGroup
                    text: qsTr("Гамма")
                }
                Slider {
                    id: gammaSlider
                    maximumValue: 3
                    minimumValue: 0
                    stepSize: 0.01
                    value: 1
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width * 0.8
                }

                RadioButton {
                    id: desaturateImageRadio
                    exclusiveGroup: imagePropertyGroup
                    text: qsTr("Ч-Б")
                }
                Slider {
                    id: desaturateSlider
                    maximumValue: 1
                    minimumValue: 0
                    stepSize: 0.01
                    value: 0
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width * 0.8
                }

                RadioButton {
                    id: hueImageRadio
                    exclusiveGroup: imagePropertyGroup
                    text: qsTr("Оттенок")
                }
                Slider {
                    id: hueSlider
                    maximumValue: 1
                    minimumValue: -1
                    stepSize: 0.01
                    value: 0
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width * 0.8
                }

                Column {
                    Layout.row: 8
                    Layout.column: 2
                    Layout.preferredWidth: parent.width * 0.8
                    Layout.alignment: Qt.AlignHCenter
                    CheckBox {
                        id: channelRed
                        text: qsTr("Красный")
                        checked: true
                    }
                    CheckBox {
                        id: channelGreen
                        text: qsTr("Зеленый")
                        checked: true
                    }
                    CheckBox {
                        id: channelBlue
                        text: qsTr("Синий")
                        checked: true
                    }
                }
            }
        }

        RowLayout {
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.width
            id: columnLayout
            z: 1

            Item {
                id: pictureViewer
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: parent.width - 120
                z: 1

                MouseArea {
                    id: pictureViewerArea
                    anchors.fill: parent
                }

                InstrumentsImage {
                    id: instrumentsImage
                    z: 3
                }

                ImageGrid {
                    id: gridNorth

                    x: currentPhoto.x - width/2 * transformImage.xScale +
                       currentPhoto.width/2 * transformImage.xScale
                    y: currentPhoto.y - height/2 * transformImage.yScale +
                       currentPhoto.height/2 * transformImage.yScale

                    transform: currentPhoto.transform

                    rotation: currentPhoto.rotation - currentPhoto.azimuth
                    z: 3
                    visible: true
                    width: Math.sqrt(currentPhoto.width * currentPhoto.width +
                                    currentPhoto.height * currentPhoto.height)
                    height: Math.sqrt(currentPhoto.width * currentPhoto.width +
                                     currentPhoto.height * currentPhoto.height)

                    property var currentParent: "north"
                }


                Image {
                    id: currentPhoto

                    fillMode: Image.PreserveAspectFit
                    height: mainPage.mapComponent.newMap.tempProviderImage.height
                    rotation: parseFloat(Jazimuth)
                    transform: Scale {
                                id: transformImage
                            }
                    z: 2
                    property int id_track: Jid_track
                    property int id_photo: Jid_photo
                    property var dir: Jdir
                    property var name: Jname
                    property var lat: parseFloat(Jlat)
                    property var lon: parseFloat(Jlon)
                    property var azimuth: parseFloat(Jazimuth)
                    property var alt: parseFloat(Jalt)
                    property var path: 0
                    property var aCalibrate: parseFloat(JaCalibrate)
                    property var bCalibrate: parseFloat(JbCalibrate)
                    property var cCalibrate: parseFloat(JcCalibrate)
                    property var dCalibrate: parseFloat(JdCalibrate)
                    source: 'image://photo/' + Jdir + Jname

                    MouseArea {
                        id: dragAreaPhoto
                        hoverEnabled: true
                        anchors.fill: parent
                        anchors.margins: 0
                        drag.target: currentPhoto
                        z: 2
                        property double factor: 1.2
                        property var offsetLon: 0.00150 // эксперементальным путем
                        property var offsetLat: 0.0016 // эксперементальным путем
                    }
                    ImageGrid {
                        id: gridPicture
                        anchors.centerIn: parent.Center
                        anchors.fill: parent
                        visible: false
                        z: 3
                        property var currentParent: "picture"
                    }
                    ListView {
                        anchors.fill: currentPhoto
                        id: calibrateOnPicture
                        model: calibratePopup.calibrateModel
                        delegate: Rectangle {
                            anchors.fill: currentPhoto
                            Rectangle {
                                width: 20
                                height: 20
                                color: "red"
                                radius: 10
                                x: xPos - 10
                                y: yPos - 10
                                z: 5
                            }
                        }
                    }
                    ListView {
                        anchors.fill: currentPhoto
                        id: pointsOnPicture

                        model: pointsPhotoModel
                        delegate: Rectangle {
                            anchors.fill: currentPhoto
                                Image {
                                x: (lat-currentPhoto.lat)*currentPhoto.dCalibrate/
                                   (currentPhoto.dCalibrate*currentPhoto.aCalibrate-
                                    currentPhoto.bCalibrate*currentPhoto.cCalibrate)-
                                   (lon-currentPhoto.lon)*currentPhoto.bCalibrate/
                                   (currentPhoto.dCalibrate*currentPhoto.aCalibrate-
                                    currentPhoto.bCalibrate*currentPhoto.cCalibrate)+
                                   currentPhoto.width/2

                                y: -(lat-currentPhoto.lat)*currentPhoto.cCalibrate/
                                   (currentPhoto.dCalibrate*currentPhoto.aCalibrate-
                                    currentPhoto.bCalibrate*currentPhoto.cCalibrate)+
                                   (lon-currentPhoto.lon)*currentPhoto.aCalibrate/
                                   (currentPhoto.dCalibrate*currentPhoto.aCalibrate-
                                    currentPhoto.bCalibrate*currentPhoto.cCalibrate)+
                                   currentPhoto.height/2
                                z: 3
                                source: "qrc:///img/popupIconsSet/" + type + ".png"
                                cache: false
                                scale: 1/currentPhoto.scale
                                asynchronous: false
                                enabled: false

                                MouseArea {
                                    anchors.fill: parent
                                    z: 4
                                    preventStealing: true
                                    onClicked: {
                                        popupPoints.visible = false
                                        popupPoints.set_popup_points_position(lat,
                                                                              lon,
                                                                              id)
                                        console.log(id)
                                        popupPoints.visible = true
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: photoScroll
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: 120
                Layout.fillWidth: true
                color: "#E0E0E0"
                z: 2
                ScrollView {
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: 120
                    Layout.fillWidth: true
                    id: scrollPhotoView
                    anchors.fill: parent
                    z: 2

                    JSONListModel
                    {
                        id: sliderModel
                        id_track: currentPhoto.id_track
                    }

                    /*ListView {
                        model: sliderModel.model
                        delegate: Column {
                            Text { text: dir+ " " + url }
                        }

                    }*/

                    ListView {
                        id: sliderList
                        //property int counte: value
                        model: sliderModel.model
                        spacing: 10
                        highlightMoveDuration: 200
                        highlight: Rectangle {color: "red"; radius: 5;}
                        //Component.onCompleted: positionViewAtIndex(10, ListView.Beginning)
                        delegate: //Text {text: "image://SliderImages/" + dir + url}
                        Rectangle { // Объект для регулировки прозрачной области
                            width: 120
                            height: 80
                            color: "transparent"
                            Rectangle {
                                width: parent.width - 10;
                                height: parent.height - 10;
                                anchors.centerIn: parent

                                AnimatedImage {
                                    id: animation
                                    source: "qrc:/img/busy.gif"
                                    width: 24
                                    height: 24
                                    anchors { centerIn: parent; verticalCenterOffset: 0 }
                                }
                                /*BusyIndicator {
                                    id: busyIndicator
                                    anchors { centerIn: parent; verticalCenterOffset: 0 }
                                    visible: true
                                }*/
                                Image {
                                    source: "image://SliderImages/" + dir + url
                                    anchors.fill: parent
                                    //fillMode: Image.PreserveAspectFit
                                    asynchronous: true
                                    MouseArea{
                                        anchors.fill:parent
                                        onClicked: {
                                            currentPhoto.source = "image://photo/" + dir + url;
                                            console.log( 'image://photo/' + dir + url);
                                            sliderList.currentIndex = index
                                        }
                                    }
                                }
                            }
                        }
                    }
                    focus: true
                    Keys.onPressed: {
                        if (event.key == Qt.Key_Up) {
                            sliderList.currentIndex -= 1
                            console.log("key up")
                            currentPhoto.source = "image://photo/" +
                                    sliderModel.model.get(sliderList.currentIndex).dir +
                                    sliderModel.model.get(sliderList.currentIndex).url
                        }
                        if (event.key == Qt.Key_Down) {
                            sliderList.currentIndex += 1
                            console.log("key down")
                            currentPhoto.source = "image://photo/" +
                                    sliderModel.model.get(sliderList.currentIndex).dir +
                                    sliderModel.model.get(sliderList.currentIndex).url
                        }
                    }
                }
            }
        }
    }
}
