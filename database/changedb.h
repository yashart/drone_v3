#ifndef CHANGEDB_H
#define CHANGEDB_H

#include <QObject>
#include <QtSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>

class ChangeDB : public QObject
{
    Q_OBJECT
public:
    explicit ChangeDB(QObject *parent = 0);
    ~ChangeDB(){
        db.close();
    }
    void changePhotoLat(int id, double lat);
    void changePhotoLon(int id, double lon);
    void changePhotoAzimuth(int id, double azimuth);
    void changePhotoOffsetX(int id, double offsetX);
    void changePhotoOffsetY(int id, double offsetY);

signals:

private:
    QSqlDatabase db;
    QSqlQuery query;

public slots:
};

#endif // CHANGEDB_H
