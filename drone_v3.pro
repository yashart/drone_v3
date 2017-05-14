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
    backend/photototiles.cpp

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
    backend/photototiles.h

DISTFILES += \
    database/DataBase.db \
    .gitignore

win32
{
#    INCLUDEPATH += C:/opencv/build/include
#    LIBS += -LC:/opencv/build/lib -lopencv_core320 \
#        -lopencv_highgui320 \
#        -lopencv_imgcodecs320 \
#        -lopencv_imgproc320 \
#        -lopencv_features2d320 \
#        -lopencv_calib3d320
#    LIBS += C:/OSGeo4W/apps/Python27/libs/python27.lib
#    INCLUDEPATH += C:/OSGeo4W/apps/Python27/include
}
unix
{
    INCLUDEPATH += /usr/local/include/opencv2
    LIBS += -L/usr/local/lib
    LIBS += -lopencv_core
    LIBS += -lopencv_imgproc
    LIBS += -lopencv_highgui
    LIBS += -lopencv_imgcodecs
    LIBS += -lopencv_features2d
    LIBS += -lopencv_calib3d
}


#LIBS       += -lVLCQtCore -lVLCQtWidgets -lVLCQtQml
