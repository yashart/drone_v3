#include "database.h"
DataBase::DataBase(QObject *parent) : QObject(parent)
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("DataBase.db");
    db.open();
}

void DataBase::printTracks()
{
    //Осуществляем запрос
    QSqlQuery query;
    query.prepare("SELECT id, name FROM Tracks");
    if (!query.exec()){
        qDebug() << "Error:" << query.lastError().text();
    }

    //Выводим значения из запроса
    while (query.next())
    {
    QString _id = query.value(0).toString();
    QString name = query.value(1).toString();
    qDebug() <<_id << " " << name << "\n";
    }
}

//Функция вычисляет "центр масс" множества точек ШИРОТЫ
double DataBase::getAvgLat(int track_id)
{
    QSqlQuery query;
    query.prepare("SELECT AVG(lat) FROM Points WHERE Points.track_id = :track_id");
    query.bindValue(":track_id", track_id);
    if (!query.exec()){
        qDebug() << "Error:" << query.lastError().text();
    }

    //Выводим значения из запроса
    while (query.next())
    {
        QString lat = query.value(0).toString().toLocal8Bit().constData();
        return lat.toDouble(); // широта
    }

    return -1; //ошибка
}

//Функция вычисляет "центр масс" множества точек ДОЛГОТЫ
double DataBase::getAvgLon(int track_id)
{
    QSqlQuery query;
    query.prepare("SELECT AVG(lon) FROM Points WHERE Points.track_id = :track_id");
    query.bindValue(":track_id", track_id);
    if (!query.exec()){
        qDebug() << "Error:" << query.lastError().text();
    }

    //Выводим значения из запроса
    while (query.next())
    {
        QString lat = query.value(0).toString().toLocal8Bit().constData();
        return lat.toDouble(); // долгота
    }

    return -1; //ошибка
}

void DataBase::createLocalPoint(double lat, double lon, QString type, QString label)
{
   QSqlQuery query;
    query.prepare("INSERT INTO LocationsPoints (lat, lon, type, label) VALUES (:lat, :lon, :type, :label);");
    query.bindValue(":lat", lat);
    query.bindValue(":lon", lon);
    query.bindValue(":type", type);
    query.bindValue(":label", label);

    qDebug() << "Супер важно! " <<label;

    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
    }
    emit updateLocationsModel();
}

void DataBase::prepareDeletePoint(int id)
{
    this->prepareDelete = id;
}

void DataBase::deleteLocalPoint()
{
    QSqlQuery query;
    query.prepare("DELETE FROM LocationsPoints WHERE LocationsPoints.id = :id;");
    query.bindValue(":id", this->prepareDelete);
    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
    }

    qDebug() << query.lastQuery();
    emit updateLocationsModel();
    qDebug() << "++++++";
    this->prepareDelete = 0;
}

void DataBase::insertIntoTable(QString name)
{
    QSqlQuery query;
    query.prepare("INSERT INTO Tracks (name) VALUES (:name)");
    query.bindValue(":name", name);

    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
    }

}

int DataBase::parseCSV(QString path)
{   
    path.replace(QString("file:///"), QString(""));
    QString filePath = path;

    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << file.errorString();
        return 1;
    }

    while (!file.atEnd()) {
        QString line(file.readLine());
        QStringList csv(line.split('\t'));

        QSqlQuery query;
        query.prepare("INSERT INTO Points (track_id, lat, lon, alt, azimuth, url, type) VALUES (:id, :lat, :lon, :alt, :azimuth, :url, :type);");
        query.bindValue(":id", "3");
        query.bindValue(":lat", csv[LAT]);
        query.bindValue(":lon", csv[LON]);
        query.bindValue(":alt", csv[ALT]);
        query.bindValue(":azimuth", csv[ANGLE]);
        query.bindValue(":url", csv[IMG_PATH]);
        query.bindValue(":type", "test");

        if (!query.exec()){
            qDebug() << "Error SQLite:" << query.lastError().text();
            qDebug() << query.lastQuery();
        }
    }
    qDebug() << "Hello";
    return 0;
}

void DataBase::deleteTrack(int id)
{
    QSqlQuery query;
    query.prepare("DELETE FROM Tracks WHERE id = :idd;");
    query.bindValue(":idd", id);
    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
        qDebug() << query.lastQuery();
    }
    qDebug() << query.lastQuery();

    query.prepare("DELETE FROM Points WHERE track_id = :idd;");
    query.bindValue(":idd", id);
    if (!query.exec()){
        qDebug() << "Error SQLite:" << query.lastError().text();
        qDebug() << query.lastQuery();
    }
    emit updateTracks();
}

void DataBase::addExifDir(QString photoPath, QString trackName)
{
    /*pathToDir.replace(QString("file:///"), QString(""));
    QString filePath = pathToDir;*/
    photoPath = photoPath.replace("file:///", "");
    qDebug() << photoPath;

    QDir dir;
    dir.setFilter(QDir::Files | QDir::Hidden | QDir::NoSymLinks);
    dir.setSorting(QDir::Name);
    dir.setPath(photoPath);

    QStringList filters;
    filters << "*.jpg" << "*.jpeg";

    QFileInfoList list = dir.entryInfoList(filters, QDir::Files|QDir::NoDotAndDotDot);

    if (list.size() > 0)
    {
        QSqlQuery query;
        query.prepare("INSERT INTO Tracks (name, dir, is_check) VALUES (:name, :dir, 'false');");
        query.bindValue(":name", trackName);
        query.bindValue(":dir", QString("%1/").arg(dir.path()));
        if (!query.exec()){
            qDebug() << "Error SQLite:" << query.lastError().text();
            qDebug() << query.lastQuery();
        }

        QString lastId(QString::number(query.lastInsertId().toInt()));

        for (int i = 0; i < list.size(); ++i) {
            QFileInfo fileInfo = list.at(i);
            FILE *fp = fopen(fileInfo.absoluteFilePath().toUtf8().constData(), "rb");
            if (!fp) {
                printf("Can't open file.\n");
            }
            fseek(fp, 0, SEEK_END);
            unsigned long fsize = ftell(fp);
            rewind(fp);
            unsigned char *buf = new unsigned char[fsize];
            if (fread(buf, 1, fsize, fp) != fsize) {
                printf("Can't read file.\n");
                delete[] buf;
            }
            fclose(fp);
            easyexif::EXIFInfo result;
            int code = result.parseFrom(buf, fsize);
            delete[] buf;
            if (code) {
                printf("Error parsing EXIF: code %d\n", code);
            }
            //qDebug() << qPrintable(QString("%1").arg(fileInfo.absoluteFilePath()));

            query.prepare("INSERT INTO Points (track_id, lat, lon, alt, azimuth, url, type) VALUES (:id, :lat, :lon, :alt, :azimuth, :url, :type);");
            query.bindValue(":id", lastId);
            query.bindValue(":lat", result.GeoLocation.Latitude);
            query.bindValue(":lon", result.GeoLocation.Longitude);
            query.bindValue(":alt", result.GeoLocation.Altitude);
            query.bindValue(":azimuth", "0");
            query.bindValue(":url", fileInfo.fileName().toUtf8().constData());
            query.bindValue(":type", "type");

            if (!query.exec()){
                qDebug() << "Error SQLite:" << query.lastError().text();
                qDebug() << query.lastQuery();
            }

            //qDebug() << qPrintable(QString("%1/").arg(fileInfo.path()));
            qDebug() << "lat=" << result.GeoLocation.Latitude;
            qDebug() << "lon=" << result.GeoLocation.Longitude;
            qDebug() << "alt=" << result.GeoLocation.Altitude;
            qDebug() << fileInfo.fileName().toUtf8().constData();
            //SELECT last_insert_rowid()
        }
        emit updateTracks();
    }
}

/*void DataBase::printPoints()
{
    QSqlQuery query;
    query.prepare("SELECT track_id, lat, lon, alt, comment, type FROM Points WHERE track_id = 1");
    if (!query.exec()){
        qDebug() << "Error:" << query.lastError().text();
    }

    //Выводим значения из запроса
    while (query.next())
    {
        QString id = query.value(0).toString().toLocal8Bit().constData();
        QString lat = query.value(1).toString().toLocal8Bit().constData();
        QString lon = query.value(2).toString().toLocal8Bit().constData();
        QString alt = query.value(3).toString().toLocal8Bit().constData();
        QString comment = query.value(4).toString().toLocal8Bit().constData();
        QString type = query.value(5).toString().toLocal8Bit().constData();
        qDebug() << id << " " << lat << " " << lon  << " "<< alt << " " << comment << " " << type << "\n";
    }
}*/
