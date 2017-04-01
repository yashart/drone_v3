#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
//#include <VLCQtCore/Common.h> For vlc-qt lib
//#include <VLCQtQml/QmlVideoPlayer.h>

#include "database/database.h"
#include "database/tracksmodel.h"
#include "database/pointsmodel.h"
#include "database/imagesmodel.h"
#include "database/locationsmodel.h"
#include "database/linesModel.h"
#include "database/pointsphotomodel.h"
#include "database/changedb.h"

#include "models/rulerModel.h"

#include "providers/sliderimageprovider.h"
#include "providers/iconsprovider.h"
#include "providers/photoprovider.h"

#include "backend/tilesdownloader.h"
#include "backend/changeimage.h"

#include "math/variation_method_calibrate.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    DataBase db;
    TracksModel tracksModel;
    PointsModel pointsModel;
    ImagesModel imagesModel;
    LocationsModel locationsModel;
    LinesModel linesModel;
    PointsPhotoModel pointsPhotoModel;
    RulerModel rulerModel;


    PhotoProvider * photoProvider = new PhotoProvider();
    ChangeDB changedb;

    Variation_method_calibrate variationModel;

    TilesDownloader tilesDownloader(QCoreApplication::applicationDirPath());


    QObject::connect(&db, &DataBase::updateLocationsModel,
                     &locationsModel, &LocationsModel::updateModel);
    QObject::connect(&db, &DataBase::updateLocationsModel,
                     &pointsPhotoModel, &PointsPhotoModel::updateModel);
    QObject::connect(&db, &DataBase::updateTracks,
                     &tracksModel, &TracksModel::updateModel);

    //VlcCommon::setPluginPath(app.applicationDirPath() + "/plugins");
    //VlcQmlVideoPlayer::registerPlugin();

    QQmlApplicationEngine engine;
    QQmlContext* ctx = engine.rootContext();
    ctx->setContextProperty("dataBase", &db);
    ctx->setContextProperty("changedb", &changedb);
    ctx->setContextProperty("tracksModel", &tracksModel);
    ctx->setContextProperty("pointsModel", &pointsModel);
    ctx->setContextProperty("imagesModel", &imagesModel);
    ctx->setContextProperty("locationsModel", &locationsModel);
    ctx->setContextProperty("linesModel", &linesModel);
    ctx->setContextProperty("pointsPhotoModel", &pointsPhotoModel);
    ctx->setContextProperty("rulerModel", &rulerModel);
    ctx->setContextProperty("tilesDownloader", &tilesDownloader);
    ctx->setContextProperty("variationModel", &variationModel);

    engine.addImageProvider(QLatin1String("SliderImages"), new SliderImageProvider());
    engine.addImageProvider(QLatin1String("Icons"), new IconProvider());
    engine.addImageProvider(QLatin1String("Photo"), photoProvider);


    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
