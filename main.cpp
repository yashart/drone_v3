#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSplashScreen>
#include <QLabel>

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
#include "models/missionmodel.h"
#include "models/currentphotopointer.h"
#include "models/telemetry.h"

#include "providers/sliderimageprovider.h"
#include "providers/iconsprovider.h"
#include "providers/photoprovider.h"

#include "backend/tilesdownloader.h"
#include "backend/photototiles.h"

#include "math/variation_method_calibrate.h"

#include "serial_link.h"
#include "gcs_communicator_factory.h"
#include "mavlink_communicator.h"

int main(int argc, char *argv[])
{

    //QApplication a(argc, argv);

    //QPixmap pixmap(":/img/splash.jpg");
    //QSplashScreen splash(pixmap);
    //splash.show();

    //QLabel w;

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
    ChangeDB changedb;
    CurrentPhotoPointer photoPointer;
    Telemetry telemetry;

    PhotoProvider * photoProvider = new PhotoProvider();    

    Variation_method_calibrate variationModel;

    PhotoToTiles photoToTiles;
    //photoToTiles.translate(QString("karer.tif"), QString("17-19"));

    //TilesDownloader tilesDownloader(QCoreApplication::applicationDirPath());


    QObject::connect(&db, &DataBase::updateLocationsModel,
                     &locationsModel, &LocationsModel::updateModel);
    QObject::connect(&db, &DataBase::updateLocationsModel,
                     &pointsPhotoModel, &PointsPhotoModel::updateModel);
    QObject::connect(&db, &DataBase::updateTracks,
                     &tracksModel, &TracksModel::updateModel);

    //VlcCommon::setPluginPath(app.applicationDirPath() + "/plugins");
    //VlcQmlVideoPlayer::registerPlugin();

    domain::GcsCommunicatorFactory factory;
    domain::MavLinkCommunicator* communicator = factory.create();
    communicator->setParent(&app);

    qDebug() << "hello, ground station!";
    //domain::UdpLink link(14550, QString("127.0.0.1"), 14551);
    //domain::SerialLink link("ttyACM0", 57600);
    domain::SerialLink link("ttyUSB0", 57600);
    communicator->addLink(&link, MAVLINK_COMM_0);
    link.up();

    MissionModel missionModel(communicator, &link);

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
    ctx->setContextProperty("missionModel", &missionModel);
    ctx->setContextProperty("photoToTiles", &photoToTiles);
    //ctx->setContextProperty("tilesDownloader", &tilesDownloader);
    ctx->setContextProperty("variationModel", &variationModel);
    ctx->setContextProperty("photoPointer", &photoPointer);
    ctx->setContextProperty("telemetry", &telemetry);
    ctx->setContextProperty("link", &link);
    ctx->setContextProperty("communicator", communicator);

    engine.addImageProvider(QLatin1String("SliderImages"), new SliderImageProvider());
    engine.addImageProvider(QLatin1String("Icons"), new IconProvider());
    engine.addImageProvider(QLatin1String("Photo"), photoProvider);


    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    //splash.finish( &w );


    app.exec();
    return 0;
}
