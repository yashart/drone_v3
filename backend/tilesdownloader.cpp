#include "tilesdownloader.h"

//#include "windows.h"
using namespace std;

TilesDownloader::TilesDownloader(QString pathToCache, QObject *parent) :
    QObject(parent)
{
    this->path_to_cache = pathToCache + "/cache";
    connect(&m_WebCtrl, SIGNAL (finished(QNetworkReply*)),
                this, SLOT (fileDownloaded(QNetworkReply*))
                );

    connect(this, &TilesDownloader::downloaded, this, &TilesDownloader::loadImage);

    qDebug() << pathToCache << "/cache";
    QDir cache(pathToCache + "/cache");
    if (!cache.exists())
    {
       cache.cdUp();
       qDebug() << cache;
       cache.mkdir("cache");
    }

}

TilesDownloader::~TilesDownloader() { }

void TilesDownloader::downloadTiles(double lat1, double lon1, double lat2, double lon2)
{
    double n = qPow(2.0, 17);
    QPoint topLeft;
    QPoint bottomRight;

    double lat_rad = qDegreesToRadians(lat1);
    topLeft.setX(qFloor((lon1 + 180.0) / 360.0 * n));
    topLeft.setY(qFloor((1.0 - qLn(qTan(lat_rad) + (1 / qCos(lat_rad))) / M_PI) / 2.0 * n));
    qDebug() << topLeft.x() << " " << topLeft.y();

    lat_rad = qDegreesToRadians(lat2);
    bottomRight.setX(qFloor((lon2 + 180.0) / 360.0 * n));
    bottomRight.setY(qFloor((1.0 - qLn(qTan(lat_rad) + (1 / qCos(lat_rad))) / M_PI) / 2.0 * n));
    this->generateFilePath(QRect(topLeft, bottomRight));

}

void TilesDownloader::generateFilePath(QRect rect)
{
    QString path;
    QDir dir(this->path_to_cache + "/16");

    path = QString("http://khms1.google.com/kh/v=717&src=app&x=%2&y=%3&z=%1&s=3").arg(16).arg(rect.bottomLeft().x()).arg(rect.bottomLeft().y());

    for (int x = rect.topLeft().x(); x <= rect.bottomRight().x(); x++)
    {
        dir.mkdir(QString::number(x));
        dir.cd(QString::number(x));
        for (int y = rect.topLeft().y(); y <= rect.bottomRight().y(); y++)
        {
            this->tiles.append(QPoint(x,y));
        }
        dir.cdUp();
    }

    this->startDownload();
    qDebug() << this->tiles<< endl;
}

void TilesDownloader::fileDownloaded(QNetworkReply* pReply) {
    m_DownloadedData = pReply->readAll();
    pReply->deleteLater();

    //emit a signal
    emit downloaded();
}

QByteArray TilesDownloader::downloadedData() const {
    return m_DownloadedData;
}

void TilesDownloader::startDownload()
{
    QString url;

    int x = this->tiles.first().x();
    int y = this->tiles.first().y();

    url = QString("http://khms1.google.com/kh/v=717&src=app&x=%1&y=%2&z=%3&s=3").arg(x).arg(y).arg(16);
    QUrl imageUrl(url);
    qDebug() << url;
    QNetworkRequest request(imageUrl);
    m_WebCtrl.get(request);
}

void TilesDownloader::loadImage()
{
    QImage tileImage;
    tileImage.loadFromData(this->downloadedData());
    QString path_to_save;

    int x = this->tiles.first().x();
    int y = this->tiles.first().y();

    path_to_save = QString(this->path_to_cache + "/%3/%1/%2.jpg").arg(x).arg(y).arg(16);
    qDebug() << path_to_save;

    tileImage.save(path_to_save,"JPG");
    qDebug()<< "Изображение сохранено";
    if (!this->tiles.isEmpty())
    {
        this->tiles.pop_front();
        startDownload();
    }

}

