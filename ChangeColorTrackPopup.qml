import QtQuick 2.4

ChangeColorTrackPopupForm {
    redColorChoose.onClicked: {
        tracksModel.setColor(id, "red")
        visible = false
        linesModel.updateModel()
        tracksModel.updateModel()
        pointsModel.updateModel()
    }
    blueColorChoose.onClicked: {
        tracksModel.setColor(id, "blue")
        visible = false
        linesModel.updateModel()
        tracksModel.updateModel()
        pointsModel.updateModel()
    }
    greenColorChoose.onClicked: {
        tracksModel.setColor(id, "green")
        visible = false
        linesModel.updateModel()
        tracksModel.updateModel()
        pointsModel.updateModel()
    }
    magentaColorChoose.onClicked: {
        tracksModel.setColor(id, "magenta")
        visible = false
        linesModel.updateModel()
        tracksModel.updateModel()
        pointsModel.updateModel()
    }
    yellowColorChoose.onClicked: {
        tracksModel.setColor(id, "yellow")
        visible = false
        linesModel.updateModel()
        tracksModel.updateModel()
        pointsModel.updateModel()
    }
    grayColorChoose.onClicked: {
        tracksModel.setColor(id, "gray")
        visible = false
        linesModel.updateModel()
        tracksModel.updateModel()
        pointsModel.updateModel()
    }
    cyanColorChoose.onClicked: {
        tracksModel.setColor(id, "cyan")
        visible = false
        linesModel.updateModel()
        tracksModel.updateModel()
        pointsModel.updateModel()
    }
    whiteColorChoose.onClicked: {
        tracksModel.setColor(id, "white")
        visible = false
        linesModel.updateModel()
        tracksModel.updateModel()
        pointsModel.updateModel()
    }
    blackColorChoose.onClicked: {
        tracksModel.setColor(id, "black")
        visible = false
        linesModel.updateModel()
        tracksModel.updateModel()
        pointsModel.updateModel()
    }
}
