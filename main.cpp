#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSplashScreen>
#include <QLabel>
#include <QSettings>

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
#include "models/cachesettings.h"
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

    // Изображение-заглушка на время загрузки программы
//    QPixmap pixmap(":/img/splash.jpg");
//    QSplashScreen splash(pixmap);
//    splash.show();

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);


    // сохранение настроек программы
    QSettings settings( "config.ini", QSettings::IniFormat);

    CacheSettings cacheSettings(settings);

    settings.beginGroup( "Path" );
    settings.setValue( "relative_path", true ); // используется ли относительный путь к папке с тайлами
    settings.setValue( "path", QString("F:/SAS_Planet/cache") );
    settings.endGroup();

    // определение всех классов-моделей models/* и databese/*
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


    // Сигналы, для автоматического обновления данный треков/точек
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
    QQmlContext * ctx = engine.rootContext();

    // Перенос классов, которые используются для отображения всей информации( получают данные из базы по протоколу мавлинк и т.д.)

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
    ctx->setContextProperty("variationModel", &variationModel);
    ctx->setContextProperty("photoPointer", &photoPointer);
    ctx->setContextProperty("cacheSettings", &cacheSettings);
    ctx->setContextProperty("telemetry", &telemetry);
    ctx->setContextProperty("link", &link);
    ctx->setContextProperty("communicator", communicator);

    // Классы, отвечающие за обаботку фотографий и иконок устанавливаемых точек
    engine.addImageProvider(QLatin1String("SliderImages"), new SliderImageProvider()); // уменьшает фотографии для создания миниатюрок
    engine.addImageProvider(QLatin1String("Icons"), new IconProvider()); // географические точки
    engine.addImageProvider(QLatin1String("Photo"), photoProvider); // фотографии (яркость/контрастность/гамма)


    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    //splash.close();
    //a.quit(); // Вызывает падение на линукс системах
    //splash.finish( &w );

    app.exec();
    return 0;
}
