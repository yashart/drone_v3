#ifndef ICONPROVIDER_H
#define ICONPROVIDER_H

#include <QQuickImageProvider>

class IconProvider : public QQuickImageProvider
{
public:
    IconProvider()
        : QQuickImageProvider(QQuickImageProvider::Image)
    {
    }

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize)
    {


        QStringList temp = id.split('/');

        if(temp.size() > 0)
        {
            QString iconName;
            QString typeFigure(temp.at(0));
            QString colorFigure(temp.at(1));

            iconName.append(":/img/popupIconsSet/"); // Название изображения
            iconName.append(typeFigure);
            iconName.append("/");
            iconName.append(colorFigure);
            iconName.append(".png");

            QImage image(iconName);
            qDebug() << iconName<<endl;
            return image;
        }
    }
};

#endif // ICONPROVIDER_H
