#include "tilesdownloader.h"

TilesDownloader::TilesDownloader(QString pathToCache, QObject *parent) :
    QObject(parent)
{
    QStringList allTiles;
    allTiles << "Hello";
    connect(&m_WebCtrl, SIGNAL (finished(QNetworkReply*)),
                this, SLOT (fileDownloaded(QNetworkReply*))
                );

    connect(this, &TilesDownloader::downloaded, this, &TilesDownloader::loadImage);

    this->path_to_cache = pathToCache;
    QUrl imageUrl("http://khms1.google.com/kh/v=717&src=app&x=39601&y=20490&z=16&s=3");
    QNetworkRequest request(imageUrl);
    m_WebCtrl.get(request);
}

TilesDownloader::~TilesDownloader() { }

void TilesDownloader::fileDownloaded(QNetworkReply* pReply) {
    m_DownloadedData = pReply->readAll();
    qDebug() << pReply->url();
    //emit a signal
    pReply->deleteLater();
    emit downloaded();
}

QByteArray TilesDownloader::downloadedData() const {
    return m_DownloadedData;
}

void TilesDownloader::loadImage()
{
    QImage tileImage;
    tileImage.loadFromData(this->downloadedData());
    qDebug() << this->path_to_cache + "/1.jpg";
    tileImage.save(this->path_to_cache + "/1.jpg","JPG");
    qDebug()<< "Изображение сохранено";
}

