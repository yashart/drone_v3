import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

Window {
    id: imagePage
    property alias currentPhoto: currentPhoto
    property alias dragAreaPhoto: dragAreaPhoto

    property alias pictureViewer: pictureViewer
    property alias photoInformation: photoInformation

    property alias standartImageRadio: standartImageRadio
    property alias invertImageRadio: invertImageRadio
    property alias colorizeImageRadio: colorizeImageRadio
    property alias brightnessImageRadio: brightnessImageRadio
    property alias gammaImageRadio: gammaImageRadio
    property alias desaturateImageRadio: desaturateImageRadio
    property alias hueImageRadio: hueImageRadio

    property alias contrastSlider: contrastSlider
    property alias brightnessSlider: brightnessSlider
    property alias colorizeSlider: colorizeSlider
    property alias gammaSlider: gammaSlider
    property alias desaturateSlider: desaturateSlider
    property alias hueSlider: hueSlider

    property alias brghtnessImage: brghtnessImage
    property alias colorizeImage: colorizeImage
    property alias instrumentsImage: instrumentsImage
    property alias gammaImage: gammaImage
    property alias desaturateImage: desaturateImage
    property alias hueImage: hueImage

    height: 560
    width: 360

    RowLayout {
        anchors.fill: parent
        Window {
            color: "#E0E0E0"
            id: photoInformation
            width: 360
            height: 560
            visible: imagePage.visible
            ColumnLayout {
                anchors.fill: parent

                GridLayout {
                    columns: 3

                    ExclusiveGroup { id: imagePropertyGroup }

                    Label {
                        text: qsTr("Обычное")
                        Layout.row: 0
                        Layout.column: 0
                    }

                    Label {
                        text: qsTr("Инвертированное")
                        Layout.row: 1
                        Layout.column: 0
                    }

                    Label {
                        text: qsTr("Контраст")
                        Layout.row: 2
                        Layout.column: 0
                    }
                    Label {
                        text: qsTr("Яркость")
                        Layout.row: 3
                        Layout.column: 0
                    }
                    Label {
                        text: qsTr("Цветовой тон")
                        Layout.row: 4
                        Layout.column: 0
                    }
                    Label {
                        text: qsTr("Гамма")
                        Layout.row: 5
                        Layout.column: 0
                    }
                    Label {
                        text: qsTr("Ч-Б")
                        Layout.row: 6
                        Layout.column: 0
                    }
                    Label {
                        text: qsTr("Оттенок")
                        Layout.row: 7
                        Layout.column: 0
                    }

                    RadioButton {
                        id: standartImageRadio
                        checked: true
                        exclusiveGroup: imagePropertyGroup
                        Layout.row: 0
                        Layout.column: 1
                    }

                    RadioButton {
                        id: invertImageRadio
                        exclusiveGroup: imagePropertyGroup
                        Layout.row: 1
                        Layout.column: 1
                    }

                    RadioButton {
                        id: brightnessImageRadio
                        exclusiveGroup: imagePropertyGroup
                        Layout.row: 2
                        Layout.column: 1
                    }

                    RadioButton {
                        id: colorizeImageRadio
                        exclusiveGroup: imagePropertyGroup
                        Layout.row: 4
                        Layout.column: 1
                    }

                    RadioButton {
                        id: gammaImageRadio
                        exclusiveGroup: imagePropertyGroup
                        Layout.row: 5
                        Layout.column: 1
                    }

                    RadioButton {
                        id: desaturateImageRadio
                        exclusiveGroup: imagePropertyGroup
                        Layout.row: 6
                        Layout.column: 1
                    }
                    RadioButton {
                        id: hueImageRadio
                        exclusiveGroup: imagePropertyGroup
                        Layout.row: 7
                        Layout.column: 1
                    }

                    Slider {
                        id: contrastSlider
                        maximumValue: 1
                        minimumValue: -1
                        stepSize: 0.05
                        value: 0
                        Layout.row: 2
                        Layout.column: 2
                        Layout.fillWidth: true
                    }
                    Slider {
                        id: brightnessSlider
                        maximumValue: 1
                        minimumValue: -1
                        stepSize: 0.05
                        value: 0
                        Layout.row: 3
                        Layout.column: 2
                        Layout.fillWidth: true
                    }
                    Slider {
                        id: colorizeSlider
                        maximumValue: 1
                        minimumValue: 0
                        stepSize: 0.01
                        value: 0
                        Layout.row: 4
                        Layout.column: 2
                        Layout.fillWidth: true
                    }
                    Slider {
                        id: gammaSlider
                        maximumValue: 3
                        minimumValue: 0
                        stepSize: 0.01
                        value: 1
                        Layout.row: 5
                        Layout.column: 2
                        Layout.fillWidth: true
                    }

                    Slider {
                        id: desaturateSlider
                        maximumValue: 1
                        minimumValue: 0
                        stepSize: 0.01
                        value: 0
                        Layout.row: 6
                        Layout.column: 2
                        Layout.fillWidth: true
                    }
                    Slider {
                        id: hueSlider
                        maximumValue: 1
                        minimumValue: -1
                        stepSize: 0.01
                        value: 0
                        Layout.row: 7
                        Layout.column: 2
                        Layout.fillWidth: true
                    }
                }
            }
        }

        ColumnLayout {
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.width * 0.8
            id: columnLayout
            z: 1

            Item {
                id: pictureViewer
                Layout.preferredHeight: 0.7 * parent.height
                Layout.preferredWidth: parent.width
                z: 1

                InstrumentsImage {
                    id: instrumentsImage
                    z: 2
                }

                Image {
                    id: currentPhoto
                    fillMode: Image.PreserveAspectFit
                    height: pictureViewer.height
                    z: 2
                    property int id_photo: Jid_photo
                    property var lat: parseFloat(Jlat)
                    property var lon: parseFloat(Jlon)
                    property var azimuth: parseFloat(Jazimuth)
                    property var alt: parseFloat(Jalt)
                    property var imageName: 0
                    property var path: 0
                    property var aCalibrate: parseFloat(JaCalibrate)
                    property var bCalibrate: parseFloat(JbCalibrate)
                    property var cCalibrate: parseFloat(JcCalibrate)
                    property var dCalibrate: parseFloat(JdCalibrate)
                    source: 'image://Photo/' + Jurl

                    MouseArea {
                        id: dragAreaPhoto
                        hoverEnabled: true
                        anchors.fill: parent
                        anchors.margins: 0
                        drag.target: currentPhoto
                        z: 2
                        property var offsetLon: 0.00150 // эксперементальным путем
                        property var offsetLat: 0.0016 // эксперементальным путем
                    }
                    BrightnessContrast {
                        id: brghtnessImage
                        anchors.fill: parent
                        source: parent
                        brightness: 0
                        contrast: 0
                        visible: false
                    }
                    Colorize {
                        id: colorizeImage
                        anchors.fill: parent
                        source: parent
                        hue: 0
                        saturation: 1
                        lightness: 0.0
                        visible: false
                    }
                    GammaAdjust {
                        id: gammaImage
                        anchors.fill: parent
                        source: parent
                        gamma: 1.0
                        visible: false
                    }
                    Desaturate {
                        id: desaturateImage
                        anchors.fill: parent
                        source: parent
                        desaturation: 0
                        visible: false
                    }
                    HueSaturation {
                       id: hueImage
                       anchors.fill: parent
                       source: parent
                       hue: 0.0
                       saturation: 0.0
                       lightness: 0.0
                       visible: false
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

                Image {
                    id: grid
                    anchors.centerIn: parent.Center
                    source: "img/grid.png"
                    anchors.fill: parent
                    z: 2
                }
            }

            Rectangle {
                id: photoScroll
                Layout.preferredHeight: 0.28 * parent.height
                Layout.preferredWidth: parent.width
                Layout.fillWidth: true
                color: "#E0E0E0"
                z: 2
                ScrollView {
                    id: scrollPhotoView
                    anchors.fill: parent
                    Row {
                        LayoutMirroring.enabled: true
                        LayoutMirroring.childrenInherit: true
                        Repeater {
                            model: imagesModel
                            Image {
                                width:166
                                source: "image://SliderImages/" + dir + url
                                height: scrollPhotoView.height * 0.9
                                fillMode: Image.PreserveAspectFit
                                asynchronous: true
                                z: 2
                            }
                        }
                    }
                }
            }
        }
    }
}
