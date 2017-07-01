QT += core sql qml quick quick widgets positioning

CONFIG += c++11

SOURCES += main.cpp \
    database/linesModel.cpp \
    database/database.cpp \
    models/rulerModel.cpp \
    database/tracksmodel.cpp \
    database/pointsphotomodel.cpp \
    database/pointsmodel.cpp \
    database/locationsmodel.cpp \
    database/imagesmodel.cpp \
    exif/exifinfo.cpp \
    backend/tilesdownloader.cpp \
    providers/photoprovider.cpp \
    math/variation_method_calibrate.cpp \
    math/calibrate_known_info.cpp \
    database/changedb.cpp \
    providers/iconsprovider.cpp \
    providers/qcvhelper.cpp \
    backend/photototiles.cpp \
    models/currentphotopointer.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

win32:RC_ICONS += icon.ico

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    database/linesModel.h \
    database/database.h \
    providers/sliderimageprovider.h \
    models/rulerModel.h \
    database/tracksmodel.h \
    database/pointsphotomodel.h \
    database/pointsmodel.h \
    database/locationsmodel.h \
    database/imagesmodel.h \
    providers/iconsprovider.h \
    exif/exifinfo.h \
    backend/tilesdownloader.h \
    providers/photoprovider.h \
    math/variation_method_calibrate.h \
    math/calibrate_known_info.h \
    database/changedb.h \
    providers/qcvhelper.h \
    backend/photototiles.h \
    models/currentphotopointer.h \
    mavlink/ardupilot/ardupilotmega.h \
    mavlink/ardupilot/mavlink.h \
    mavlink/ardupilot/mavlink_msg_ahrs.h \
    mavlink/ardupilot/mavlink_msg_ahrs2.h \
    mavlink/ardupilot/mavlink_msg_ahrs3.h \
    mavlink/ardupilot/mavlink_msg_airspeed_autocal.h \
    mavlink/ardupilot/mavlink_msg_ap_adc.h \
    mavlink/ardupilot/mavlink_msg_autopilot_version_request.h \
    mavlink/ardupilot/mavlink_msg_battery2.h \
    mavlink/ardupilot/mavlink_msg_camera_feedback.h \
    mavlink/ardupilot/mavlink_msg_camera_status.h \
    mavlink/ardupilot/mavlink_msg_compassmot_status.h \
    mavlink/ardupilot/mavlink_msg_data16.h \
    mavlink/ardupilot/mavlink_msg_data32.h \
    mavlink/ardupilot/mavlink_msg_data64.h \
    mavlink/ardupilot/mavlink_msg_data96.h \
    mavlink/ardupilot/mavlink_msg_digicam_configure.h \
    mavlink/ardupilot/mavlink_msg_digicam_control.h \
    mavlink/ardupilot/mavlink_msg_ekf_status_report.h \
    mavlink/ardupilot/mavlink_msg_fence_fetch_point.h \
    mavlink/ardupilot/mavlink_msg_fence_point.h \
    mavlink/ardupilot/mavlink_msg_fence_status.h \
    mavlink/ardupilot/mavlink_msg_gimbal_control.h \
    mavlink/ardupilot/mavlink_msg_gimbal_report.h \
    mavlink/ardupilot/mavlink_msg_gimbal_torque_cmd_report.h \
    mavlink/ardupilot/mavlink_msg_gopro_get_request.h \
    mavlink/ardupilot/mavlink_msg_gopro_get_response.h \
    mavlink/ardupilot/mavlink_msg_gopro_heartbeat.h \
    mavlink/ardupilot/mavlink_msg_gopro_set_request.h \
    mavlink/ardupilot/mavlink_msg_gopro_set_response.h \
    mavlink/ardupilot/mavlink_msg_hwstatus.h \
    mavlink/ardupilot/mavlink_msg_led_control.h \
    mavlink/ardupilot/mavlink_msg_limits_status.h \
    mavlink/ardupilot/mavlink_msg_mag_cal_progress.h \
    mavlink/ardupilot/mavlink_msg_mag_cal_report.h \
    mavlink/ardupilot/mavlink_msg_meminfo.h \
    mavlink/ardupilot/mavlink_msg_mount_configure.h \
    mavlink/ardupilot/mavlink_msg_mount_control.h \
    mavlink/ardupilot/mavlink_msg_mount_status.h \
    mavlink/ardupilot/mavlink_msg_pid_tuning.h \
    mavlink/ardupilot/mavlink_msg_radio.h \
    mavlink/ardupilot/mavlink_msg_rally_fetch_point.h \
    mavlink/ardupilot/mavlink_msg_rally_point.h \
    mavlink/ardupilot/mavlink_msg_rangefinder.h \
    mavlink/ardupilot/mavlink_msg_remote_log_block_status.h \
    mavlink/ardupilot/mavlink_msg_remote_log_data_block.h \
    mavlink/ardupilot/mavlink_msg_rpm.h \
    mavlink/ardupilot/mavlink_msg_sensor_offsets.h \
    mavlink/ardupilot/mavlink_msg_set_mag_offsets.h \
    mavlink/ardupilot/mavlink_msg_simstate.h \
    mavlink/ardupilot/mavlink_msg_wind.h \
    mavlink/ardupilot/testsuite.h \
    mavlink/ardupilot/version.h

DISTFILES += \
    database/DataBase.db \
    .gitignore \
    jsonpath.js \
    AddTrackForm.ui.qml \
    AddTracksForm.ui.qml \
    CalibratePopupForm.ui.qml \
    ChangeColorTrackPopupForm.ui.qml \
    DroneV3Form.ui.qml \
    ImagePageForm.ui.qml \
    InstrumentsForm.ui.qml \
    InstrumentsImageForm.ui.qml \
    LeftTabMenuForm.ui.qml \
    LoginPageForm.ui.qml \
    MainMenuForm.ui.qml \
    MainPageForm.ui.qml \
    MapWindowForm.ui.qml \
    OpenTracksForm.ui.qml \
    Page1Form.ui.qml \
    PopupPointsForm.ui.qml \
    AddTrack.qml \
    AddTracks.qml \
    BusyIndicator.qml \
    CalibratePopup.qml \
    ChangeColorTrackPopup.qml \
    ChooseTrackDirDialog.qml \
    CustomPlugin.qml \
    DroneV3.qml \
    EsriPlugin.qml \
    ExportFileDialog.qml \
    HerePlugin.qml \
    ImageGrid.qml \
    ImagePage.qml \
    ImagePageModel.qml \
    ImagePageSlider.qml \
    Instruments.qml \
    InstrumentsImage.qml \
    JSONListModel.qml \
    LeftTabMenu.qml \
    LoginPage.qml \
    main.qml \
    MainMenu.qml \
    MainPage.qml \
    MapboxPlugin.qml \
    MapComponent.qml \
    MapTemplate.qml \
    MapWindow.qml \
    OpenTracks.qml \
    OsmPlugin.qml \
    Page1.qml \
    PopupPoints.qml \
    TihoretskPlugin.qml \
    VideoWindows.qml \
    models/TrackPointer.qml \
    TrackPointer.qml \
    ControlForm.ui.qml \
    Control.qml

win32
{
    INCLUDEPATH += C:/opencv/build/include
    LIBS += -LC:/opencv/build/bin -lopencv_core320 \
        -lopencv_highgui320 \
        -lopencv_imgcodecs320 \
        -lopencv_imgproc320 \
        -lopencv_features2d320 \
        -lopencv_calib3d320
    #LIBS += C:/OSGeo4W/apps/Python27/libs/python27.lib
    #INCLUDEPATH += C:/OSGeo4W/apps/Python27/include
}
unix
{
#    INCLUDEPATH += /usr/local/include/opencv2
#    LIBS += -L/usr/local/lib
#    LIBS += -lopencv_core
#    LIBS += -lopencv_imgproc
#    LIBS += -lopencv_highgui
#    LIBS += -lopencv_imgcodecs
#    LIBS += -lopencv_features2d
#    LIBS += -lopencv_calib3d
}


#LIBS       += -lVLCQtCore -lVLCQtWidgets -lVLCQtQml
