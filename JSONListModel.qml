/* JSONListModel - a QML ListModel with JSON and JSONPath support
 *
 * Copyright (c) 2012 Romain Pokrzywka (KDAB) (romain@kdab.com)
 * Licensed under the MIT licence (http://opensource.org/licenses/mit-license.php)
 */

import QtQuick 2.5

Item {
    property int id_track: 0
    property string json: ""
    property string query: ""


    property ListModel model : ListModel { id: jsonModel }
    property alias count: jsonModel.count

    onId_trackChanged: {
        imagesModel.changeId(id_track)
        imagesModel.updateModel()
        updateJSONModel()
        console.log("Update!!! " + id_track)
    }

    onJsonChanged: updateJSONModel()
    onQueryChanged: updateJSONModel()

    function updateJSONModel() {
        jsonModel.clear();


        for (var i = 0; i<imagesModel.rowCount(); i++) {
            var iUrl = imagesModel.get(i,"url")
            var iDir = imagesModel.get(i,"dir")
            var iACalibrate = imagesModel.get(i,"aCalibrate")
            var iBCalibrate = imagesModel.get(i,"bCalibrate")
            var iCCalibrate = imagesModel.get(i,"cCalibrate")
            var iDCalibrate = imagesModel.get(i,"dCalibrate")
            var iAzimuth = imagesModel.get(i,"azimuth")
            jsonModel.append({dir: iDir, url:iUrl,
                             aCalibrate: iACalibrate,
                             bCalibrate: iBCalibrate,
                             cCalibrate: iCCalibrate,
                             dCalibrate: iDCalibrate,
                             azimuth: iAzimuth
                             })
            console.log()
        }
    }
}
