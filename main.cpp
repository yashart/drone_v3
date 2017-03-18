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
#include "models/rulerModel.h"
#include "providers/sliderimageprovider.h"
#include "providers/iconsprovider.h"
#include "backend/tilesdownloader.h"


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


    QUrl imageUrl("http://khms1.google.com/kh/v=717&src=app&x=39601&y=20490&z=16&s=3");
    TilesDownloader m_pImgCtrl(imageUrl);

    //db.addExifDir("D:/Shurup/ortophoto");
    //db.addExifDir("D:/VladPole", "VladPole");
    //db.deleteTrack(17);

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
    ctx->setContextProperty("tracksModel", &tracksModel);
    ctx->setContextProperty("pointsModel", &pointsModel);
    ctx->setContextProperty("imagesModel", &imagesModel);
    ctx->setContextProperty("locationsModel", &locationsModel);
    ctx->setContextProperty("linesModel", &linesModel);
    ctx->setContextProperty("pointsPhotoModel", &pointsPhotoModel);
    ctx->setContextProperty("rulerModel", &rulerModel);

    engine.addImageProvider(QLatin1String("SliderImages"), new SliderImageProvider());
    engine.addImageProvider(QLatin1String("Icons"), new IconProvider());

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
