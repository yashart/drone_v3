#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QQuickImageProvider>
#include <QPainter>

class SliderImageProvider : public QQuickImageProvider
{
public:
    SliderImageProvider()
        : QQuickImageProvider(QQuickImageProvider::Image)
    {
    }

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize)
    {
        QImage image(id);

        image = image.scaled(166, 100, Qt::KeepAspectRatio, Qt::SmoothTransformation);
        return image;
    }
};

#endif // IMAGEPROVIDER_H
