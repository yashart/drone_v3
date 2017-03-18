#ifndef TILESDOWNLOADER_H
#define TILESDOWNLOADER_H

#include <QObject>
#include <QByteArray>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QImage>


class TilesDownloader : public QObject
{
 Q_OBJECT
 public:
  explicit TilesDownloader(QString pathToCache, QObject *parent = 0);
  virtual ~TilesDownloader();
  QByteArray downloadedData() const;

 signals:
  void downloaded();

 private slots:
  void fileDownloaded(QNetworkReply* pReply);
  void loadImage();

 private:
  QString path_to_cache;
  QNetworkAccessManager m_WebCtrl;
  QByteArray m_DownloadedData;
};


#endif // TILESDOWNLOADER_H
