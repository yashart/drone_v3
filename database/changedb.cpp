#include "changedb.h"

ChangeDB::ChangeDB(QObject *parent) : QObject(parent)
{

}

void ChangeDB::changePhotoLat(int id, double lat)
{
    query.prepare("UPDATE Points SET lat = :lat WHERE id = :id;");
    query.bindValue(":id", id);
    query.bindValue(":lat", lat);

    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
    }
}

void ChangeDB::changePhotoLon(int id, double lon)
{
    query.prepare("UPDATE Points SET lon = :lon WHERE id = :id;");
    query.bindValue(":id", id);
    query.bindValue(":lon", lon);

    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
    }
}


void ChangeDB::changePhotoAzimuth(int id, double azimuth)
{
    query.prepare("UPDATE Points SET azimuth = :azimuth WHERE id = :id;");
    query.bindValue(":id", id);
    query.bindValue(":azimuth", azimuth);

    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
    }
}

void ChangeDB::changePhotoOffsetX(int id, double offsetX)
{
    query.prepare("UPDATE Points SET offsetX = :offsetX WHERE id = :id;");
    query.bindValue(":id", id);
    query.bindValue(":offsetX", offsetX);

    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
    }
}

void ChangeDB::changePhotoOffsetY(int id, double offsetY)
{
    query.prepare("UPDATE Points SET offsetY = :offsetY WHERE id = :id;");
    query.bindValue(":id", id);
    query.bindValue(":offsetY", offsetY);

    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
    }
}
