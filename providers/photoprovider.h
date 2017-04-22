#ifndef PHOTOPROVIDER_H
#define PHOTOPROVIDER_H

#include <QObject>
#include <QQuickImageProvider>
#include <QPainter>
#include <QTime>
#include <QUrl>
#include <QUrlQuery>

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

class PhotoProvider : public QQuickImageProvider
{
public:
    PhotoProvider()
        : QQuickImageProvider(QQuickImageProvider::Image)
    {
        curImg = cv::imread("C:/Users/Vladislav/Downloads/Capture_01.JPG" , 1 );
        tempImg = curImg.clone();
    }

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);
    void changePath(QString path);
private:

    cv::Mat curImg;
    cv::Mat tempImg;
    QString path;
};

#endif // PHOTOPROVIDER_H
