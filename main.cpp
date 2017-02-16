#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "database/database.h"
#include "database/tracksmodel.h"
#include "database/pointsmodel.h"
#include "database/imagesmodel.h"
#include "database/locationsmodel.h"
#include "database/linesModel.h"
#include "database/pointsphotomodel.h"
#include "models/rulerModel.h"

int main(int argc, char *argv[])
{
    DataBase db;
    TracksModel tracksModel;
    PointsModel pointsModel;
    ImagesModel imagesModel;
    LocationsModel locationsModel;
    LinesModel linesModel;
    PointsPhotoModel pointsPhotoModel;
    RulerModel rulerModel;
    linesModel.addId("1");
    linesModel.addId("3");


    QObject::connect(&db, &DataBase::updateLocationsModel,
                     &locationsModel, &LocationsModel::updateModel);
    QObject::connect(&db, &DataBase::updateLocationsModel,
                     &pointsPhotoModel, &PointsPhotoModel::updateModel);


    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

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


    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
