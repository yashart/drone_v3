import QtQuick 2.0
import QtLocation 5.3
import QtPositioning 5.3

Map {
    id: map
    anchors.fill: parent
    center: QtPositioning.coordinate(59.91, 10.75)
    MapItemView{
        id: tracksLines
        model: linesModel
        delegate: MapPolyline {
            line.width: 2
            line.color: 'blue'
            path: points
            z: 2
        }
    }
    MapItemView{
        id: secondView
        model: pointsModel
        onAdd: {
            console.log("1")
        }

        delegate: MapQuickItem {
            coordinate: QtPositioning.coordinate(lat, lon)
            anchorPoint.x: markerTrackPoint.width / 2;
            anchorPoint.y: markerTrackPoint.height / 2;
            opacity:0
            sourceItem: Image {
                id: markerTrackPoint
                z: 2
                source: "img/photo.png"
            }

            property var image_src: -1

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    parent.opacity = 1;
                }
                onExited: {
                    parent.opacity = 0;
                }
            }
        }
    }
}
