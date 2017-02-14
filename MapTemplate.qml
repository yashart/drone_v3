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
}
