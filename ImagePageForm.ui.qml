import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0

Window {
    id: imagePage
    property alias currentPhoto: currentPhoto
    property alias dragAreaPhoto: dragAreaPhoto
    property alias pictureViewer: pictureViewer
    height: 360
    width: 360
    ColumnLayout {
        anchors.fill: parent
        id: columnLayout

        Item {
            id: pictureViewer
            Layout.preferredHeight: 0.7 * parent.height
            Layout.preferredWidth: parent.width
            Flickable {
                anchors.fill: parent
                contentWidth: 3 * parent.width
                contentHeight: 3 * parent.height
                leftMargin: parent.width
                rightMargin: parent.width
                topMargin: parent.height
                bottomMargin: parent.height
                Image {
                    id: currentPhoto
                    fillMode: Image.PreserveAspectFit
                    height: pictureViewer.height
                    source: "img/photo_example.jpg"
                    z: 2
                    property var lat: 0
                    property var lon: 0
                    property var azimuth: 0
                    ListView {
                        anchors.fill: parent
                        id: pointsOnPicture

                        model: pointsPhotoModel
                        delegate: Image {
                            x: (((lon-currentPhoto.lon)/dragAreaPhoto.offsetLon*Math.cos(currentPhoto.azimuth*3.1415/180)-
                               (currentPhoto.lat-lat)/dragAreaPhoto.offsetLat*Math.sin(currentPhoto.azimuth*3.1415/180))/2 + 0.5)*currentPhoto.paintedWidth
                            y: (((currentPhoto.lat-lat)/dragAreaPhoto.offsetLat*Math.cos(currentPhoto.azimuth*3.1415/180)-
                               (currentPhoto.lon-lon)/dragAreaPhoto.offsetLon*Math.sin(currentPhoto.azimuth*3.1415/180))/2 + 0.5)*currentPhoto.paintedHeight
                            z: 3
                            source: "qrc:///img/popupIconsSet/" + type + ".png"
                            cache: false
                            asynchronous: false
                            enabled: false



                            Timer {
                            interval: 500; running: true; repeat: true
                                onTriggered: {
                                    parent.x = -1;
                                    parent.y = -1;
                                    parent.x = (((lon-currentPhoto.lon)/dragAreaPhoto.offsetLon*Math.cos(currentPhoto.azimuth*3.1415/180)-
                                                 (currentPhoto.lat-lat)/dragAreaPhoto.offsetLat*Math.sin(currentPhoto.azimuth*3.1415/180))/2 + 0.5)*currentPhoto.paintedWidth
                                    parent.y = (((currentPhoto.lat-lat)/dragAreaPhoto.offsetLat*Math.cos(currentPhoto.azimuth*3.1415/180)-
                                                 (currentPhoto.lon-lon)/dragAreaPhoto.offsetLon*Math.sin(currentPhoto.azimuth*3.1415/180))/2 + 0.5)*currentPhoto.paintedHeight
                                }
                            }

                        }
                    }
                }
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
            }
            Image {
                id: grid
                anchors.centerIn: parent.Center
                source: "img/grid.png"
                anchors.fill: parent
                z: 2
            }
        }

        Item {
            id: photoScroll
            Layout.preferredHeight: 0.28 * parent.height
            Layout.preferredWidth: parent.width
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
