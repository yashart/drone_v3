#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QtSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>

#include "exif/exifinfo.h"

#define LAT 2
#define LON 1
#define ALT 3
#define IMG_PATH 0
#define ANGLE 6

class DataBase : public QObject
{
    Q_OBJECT
private:
    QSqlDatabase db;
    int prepareDelete = 0;
public:
    explicit DataBase(QObject *parent = 0);
    ~DataBase(){
     db.close();
    }

signals:
    void updateLocationsModel();
    void updateTracks();

public slots:
    void printTracks();
    //void printPoints();
    double getAvgLat(int track_id);
    double getAvgLon(int track_id);
    void insertIntoTable(QString name);
    int parseCSV(QString path);
    void createLocalPoint(double lat, double lon, QString type);
    void prepareDeletePoint(int id);
    void deleteLocalPoint();
    void addExifDir(QString photoPath, QString trackName);
    void deleteTrack(int id);
};

#endif // DATABASE_H
