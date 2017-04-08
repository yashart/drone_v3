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
    Q_INVOKABLE void changePhotoLat(int id, double lat);
    Q_INVOKABLE void changePhotoLon(int id, double lon);
    Q_INVOKABLE void changePhotoAzimuth(int id, double azimuth);
    Q_INVOKABLE void changePhotoOffsetX(int id, double offsetX);
    Q_INVOKABLE void changePhotoOffsetY(int id, double offsetY);
    Q_INVOKABLE void changePhotoGeoreferencing(int id,
                                               double aCalibrate,
                                               double bCalibrate,
                                               double cCalibrate,
                                               double dCalibrate);

signals:

private:
    QSqlDatabase db;
    QSqlQuery query;

public slots:
};

#endif // CHANGEDB_H
