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

        image = image.scaled(120, 70, Qt::KeepAspectRatio, Qt::SmoothTransformation);
        size->setWidth( requestedSize.width() );
        size->setHeight( requestedSize.height() );
        return image;
    }
};

#endif // IMAGEPROVIDER_H
