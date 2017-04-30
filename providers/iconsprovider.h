#ifndef ICONPROVIDER_H
#define ICONPROVIDER_H

#include <QQuickImageProvider>
#include <QObject>
#include <vector>
#include <QFile>

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

#include "qcvhelper.h"

class IconProvider : public QQuickImageProvider
{
public:
    IconProvider()
        : QQuickImageProvider(QQuickImageProvider::Image)
    {
    }

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);
};

#endif // ICONPROVIDER_H
