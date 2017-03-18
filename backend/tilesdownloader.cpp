#include "tilesdownloader.h"

TilesDownloader::TilesDownloader(QUrl imageUrl, QObject *parent) :
    QObject(parent)
{
    connect(&m_WebCtrl, SIGNAL (finished(QNetworkReply*)),
                this, SLOT (fileDownloaded(QNetworkReply*))
                );

    connect(this, &TilesDownloader::downloaded, this, &TilesDownloader::loadImage);

    QNetworkRequest request(imageUrl);
    m_WebCtrl.get(request);
}

TilesDownloader::~TilesDownloader() { }

void TilesDownloader::fileDownloaded(QNetworkReply* pReply) {
    m_DownloadedData = pReply->readAll();
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
    tileImage.save(PATH_TO_LOCAL_CACHE,"JPG");
    qDebug()<< "Изображение сохранено";
}

