#ifndef TILESDOWNLOADER_H
#define TILESDOWNLOADER_H

#include <QObject>
#include <QByteArray>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QImage>

#define PATH_TO_LOCAL_CACHE "D://1.jpg"

class TilesDownloader : public QObject
{
 Q_OBJECT
 public:
  explicit TilesDownloader(QUrl imageUrl, QObject *parent = 0);
  virtual ~TilesDownloader();
  QByteArray downloadedData() const;

 signals:
  void downloaded();

 private slots:
  void fileDownloaded(QNetworkReply* pReply);
  void loadImage();

 private:
  QNetworkAccessManager m_WebCtrl;
  QByteArray m_DownloadedData;
};


#endif // TILESDOWNLOADER_H
