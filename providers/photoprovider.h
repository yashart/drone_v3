#ifndef PHOTOPROVIDER_H
#define PHOTOPROVIDER_H

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
};

#endif // PHOTOPROVIDER_H
