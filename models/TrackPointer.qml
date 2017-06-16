import QtQuick 2.5
import QtLocation 5.5
import QtPositioning 5.3
import QtQuick.Controls 2.1

Item {
    id: trackPointer
    ListModel{
        id: modelPointer
        ListElement{
            track_id: 1
            coordinate: QtPositioning.coordinate(55.7463816, 37.55232)
        }
    }

    /*function addPointer(){}
    function delPointer(){}*/

    MapItemView {
        model: modelPointer
        MapQuickItem{
            coordinate: coordinate
            anchorPoint.x: finishRulerIcon.width / 2;
            anchorPoint.y: finishRulerIcon.height / 2;
            sourceItem:
                Column{
                    Image {id: finishRulerIcon; source: "qrc:/img/drone.png"}
                }
        }
    }
}
