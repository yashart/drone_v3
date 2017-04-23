import QtQuick 2.0

Item {
    property alias imagePageModel: imagePageModel
    ListView {
        model: imagePageModel
        delegate: Item {
                ImagePage {
                    id: imagePage
                    visible: Jvisible
                }
        }
    }

    ListModel {
        id: imagePageModel
    }

    function addTrack(id, name){
        imagePageModel.append({"name": name,
                              "id": id,
                              "Jdir": "1",
                              "Jname": "1",
                              "Jheight": 0,
                              "Jrotation": 0,
                              "Jazimuth": 0,
                              "Jlat": 0,
                              "Jlon": 0,
                              "Jalt": 0,
                              "Jid_photo": 0,
                              "JaCalibrate": 0,
                              "JbCalibrate": 0,
                              "JcCalibrate": 0,
                              "JdCalibrate": 0,
                              "Jvisible": false})
    }

    function setPhotoParams(id, url, dir, height, rotation, azimuth, lat, lon,
                            alt, id_photo, aCalibrate, bCalibrate, cCalibrate,
                            dCalibrate){
        for (var i = 0; i < imagePageModel.count; i+=1){
            if(imagePageModel.get(i).id == id){
                imagePageModel.set(i,
                                   {"name": imagePageModel.get(i).name,
                                       "id": id,
                                       "Jdir": dir,
                                       "Jname": url,
                                       "Jheight": height,
                                       "Jrotation": rotation,
                                       "Jazimuth": azimuth,
                                       "Jlat": lat,
                                       "Jlon": lon,
                                       "Jalt": alt,
                                       "Jid_photo": id_photo,
                                       "JaCalibrate": aCalibrate,
                                       "JbCalibrate": bCalibrate,
                                       "JcCalibrate": cCalibrate,
                                       "JdCalibrate": dCalibrate,
                                       "Jvisible": true})
            }
        }
    }

    function removeTrack(id){
        for (var i = 0; i < imagePageModel.count; i+=1){
            if(imagePageModel.get(i).id == id){
                imagePageModel.remove(i)
            }
        }
    }
}
