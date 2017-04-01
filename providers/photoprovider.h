#ifndef PHOTOPROVIDER_H
#define PHOTOPROVIDER_H

#include <QObject>
#include <QQuickImageProvider>
#include <QPainter>

class PhotoProvider : public QQuickImageProvider
{
public:
    PhotoProvider()
        : QQuickImageProvider(QQuickImageProvider::Image)
    {
    }

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);
    void changePath(QString path);
private:
    void changeMainImage(QString name);

    QImage main_image;
    QString old_image_name;
    QString path;
};

#endif // PHOTOPROVIDER_H
