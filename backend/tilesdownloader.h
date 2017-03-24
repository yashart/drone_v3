#ifndef TILESDOWNLOADER_H
#define TILESDOWNLOADER_H

#include <QObject>
#include <QByteArray>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QImage>
#include <QRect>
#include <QtMath>
#include <QDir>
#include <QPoint>
#include <QTime>
#include <dos.h>
#include <stdio.h>


class TilesDownloader : public QObject
{
 Q_OBJECT
 public:
  explicit TilesDownloader(QString pathToCache, QObject *parent = 0);
  virtual ~TilesDownloader();
  QByteArray downloadedData() const;

  Q_INVOKABLE void downloadTiles(double lat1, double lon1, double lat2, double lon2);

 signals:
  void downloaded();

 private slots:
  void fileDownloaded(QNetworkReply* pReply);
  void loadImage();

 private:
  QString path_to_cache;
  QNetworkAccessManager m_WebCtrl;
  QByteArray m_DownloadedData;

  void generateFilePath(QRect rect);
  void startDownload();

  QStringList urlList;
  QList<QPoint> tiles;
};


#endif // TILESDOWNLOADER_H
