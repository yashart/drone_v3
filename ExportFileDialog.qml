import QtQuick 2.0
import QtQuick.Dialogs 1.2

FileDialog {
    id: exportFileDialog
    title: "Please choose a file"
    folder: shortcuts.home
    onAccepted: {
         photoToTiles.translate(exportFileDialog.fileUrls,"17-20")
    }
    onRejected: {
        console.log("Canceled")
    }
    //Component.onCompleted: visible = true
}
