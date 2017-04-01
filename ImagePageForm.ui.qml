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
    property alias contrastSlider: contrastSlider
    property alias brightnessSlider: brightnessSlider
    property alias brghtnessImage: brghtnessImage
    property alias instrumentsImage: instrumentsImage
    height: 560
    width: 360
    RowLayout {
        anchors.fill: parent
        Window {
            color: "#E0E0E0"
            id: photoInformation
            //Layout.preferredWidth: parent.width * 0.2
            //Layout.preferredHeight: parent.height
            width: 360
            height: 560
            visible: imagePage.visible
            ColumnLayout {
                anchors.fill: parent

                Label {
                    text: qsTr("Трек:")
                    font.bold: true
                }

                Label {
                    id: trackName
                }

                Label {
                    text: qsTr("Фотография")
                    font.bold: true
                }

                Label {
                    id: photoName
                    text: currentPhoto.source
                    font.pointSize: 8
                }

                Label {
                    text: qsTr("Широта")
                    font.bold: true
                }

                Label {
                    id: photoLat
                    text: currentPhoto.lat
                }

                Label {
                    text: qsTr("Долгота")
                    font.bold: true
                }

                Label {
                    id: photoLon
                    text: currentPhoto.lon
                }

                Label {
                    text: qsTr("Азимут")
                    font.bold: true
                }

                Label {
                    id: photoAzimuth
                    text: currentPhoto.azimuth
                }

                Label {
                    text: qsTr("Поворот фото")
                    font.bold: true
                }

                Label {
                    id: photoRotation
                    text: currentPhoto.rotation % 360
                }

                Label {
                    text: qsTr("Высота")
                    font.bold: true
                }

                Label {
                    id: photoAlt
                    text: currentPhoto.alt
                }

                Label {
                    text: qsTr("Режимы фото")
                    font.bold: true
                }

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

                    Slider {
                        id: contrastSlider
                        maximumValue: 1
                        minimumValue: -1
                        stepSize: 0.1
                        value: 0
                        Layout.row: 2
                        Layout.column: 1
                        Layout.fillWidth: true
                    }
                    Slider {
                        id: brightnessSlider
                        maximumValue: 1
                        minimumValue: -1
                        stepSize: 0.1
                        value: 0
                        Layout.row: 3
                        Layout.column: 1
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
                    property var lat: 0
                    property var lon: 0
                    property var azimuth: 0
                    property var alt: 0
                    property var imageName: 0
                    MouseArea {
                        id: dragAreaPhoto
                        hoverEnabled: true
                        anchors.fill: parent
                        anchors.margins: 0
                        drag.target: currentPhoto
                        z: 2
                        property var offsetLon: 0.00150 // эксперементальным путем
                        property var offsetLat: 0.0016 // эксперементальным путем

                        BrightnessContrast {
                            id: brghtnessImage
                            anchors.fill: parent
                            source: parent
                            brightness: 0
                            contrast: 0
                        }
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
                                x: (((lon-currentPhoto.lon)/dragAreaPhoto.offsetLon*Math.cos(currentPhoto.azimuth*3.1415/180)-
                                   (currentPhoto.lat-lat)/dragAreaPhoto.offsetLat*Math.sin(currentPhoto.azimuth*3.1415/180))/2 + 0.5)*currentPhoto.paintedWidth
                                y: (((currentPhoto.lat-lat)/dragAreaPhoto.offsetLat*Math.cos(currentPhoto.azimuth*3.1415/180)-
                                   (currentPhoto.lon-lon)/dragAreaPhoto.offsetLon*Math.sin(currentPhoto.azimuth*3.1415/180))/2 + 0.5)*currentPhoto.paintedHeight
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
