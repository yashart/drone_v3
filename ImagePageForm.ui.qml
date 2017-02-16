import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0

Window {
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
                    z: 1
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
                    Repeater {
                        model: 10
                        Image {
                            source: "img/photo_example.jpg"
                            height: scrollPhotoView.height * 0.9
                            fillMode: Image.PreserveAspectFit
                            z: 2
                        }
                    }
                }
            }
        }
    }
}
