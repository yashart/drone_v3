import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.0 as C2

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

    Rectangle {
        id: sliderContainer
        height: parent.height
        width: sliderRow.width + 10
        visible: sliderToggler.checked
        color: Qt.rgba( 1, 0 / 255.0, 0 / 255.0, 0.2)

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

            // the sliders value labels
            Row {
                id: rowSliderValues
                spacing: sliderRow.spacing
                width: sliderRow.width
                height: 32
                property real entryWidth: zoomSlider.width

                Rectangle{
                    color: labelBackground
                    height: parent.height
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelZoomValue
                        text: zoomSlider.value.toFixed(3)
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }
                Rectangle{
                    color: labelBackground
                    height: parent.height
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelBearingValue
                        text: bearingSlider.value.toFixed(2)
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }
                Rectangle{
                    color: labelBackground
                    height: parent.height
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelTiltValue
                        text: tiltSlider.value.toFixed(2)
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }
                Rectangle{
                    color: labelBackground
                    height: parent.height
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelFovValue
                        text: fovSlider.value.toFixed(2)
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }
            } // rowSliderValues

            // The sliders row
            Column {
                spacing: -10
                width: 150
                id: sliderRow
                height: sliderContainer.slidersHeight

                C2.Slider {
                    id: zoomSlider
                    height: parent.height
                    orientation : Qt.Horizontal
                    from : containerRow.mapSource.minimumZoomLevel
                    to : containerRow.mapSource.maximumZoomLevel
                    value : containerRow.mapSource.zoomLevel
                    onValueChanged: {
                            containerRow.mapSource.zoomLevel = value
                    }
                }
                C2.Slider {
                    id: bearingSlider
                    height: parent.height
                    from: 0
                    to: 360
                    orientation : Qt.Horizontal
                    value: containerRow.mapSource.bearing
                    onValueChanged: {
                        containerRow.mapSource.bearing = value;
                    }
                }
                C2.Slider {
                    id: tiltSlider
                    height: parent.height
                    orientation : Qt.Horizontal
                    from: containerRow.mapSource.minimumTilt;
                    to: containerRow.mapSource.maximumTilt
                    value: containerRow.mapSource.tilt
                    onValueChanged: {
                        containerRow.mapSource.tilt = value;
                    }
                }
                C2.Slider {
                    id: fovSlider
                    height: parent.height
                    orientation : Qt.Horizontal
                    from: containerRow.mapSource.minimumFieldOfView
                    to: containerRow.mapSource.maximumFieldOfView
                    value: containerRow.mapSource.fieldOfView
                    onValueChanged: {
                        containerRow.mapSource.fieldOfView = value;
                    }
                }
            } // Row sliders

            // The labels row
            Column {
                id: rowSliderLabels
                spacing: sliderRow.spacing
                width: sliderRow.width
                property real entryWidth: zoomSlider.width
                property real entryHeight: 64

                Rectangle{
                    color: labelBackground
                    height: parent.entryHeight
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelZoom
                        text: "Zoom"
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }

                Rectangle{
                    color: labelBackground
                    height: parent.entryHeight
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelBearing
                        text: "Bearing"
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }
                Rectangle{
                    color: labelBackground
                    height: parent.entryHeight
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelTilt
                        text: "Tilt"
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }
                Rectangle{
                    color: labelBackground
                    height: parent.entryHeight
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelFov
                        text: "FoV"
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }
            } // rowSliderLabels
        } // Column
    } // sliderContainer
} // containerRow
