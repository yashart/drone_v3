#include "providers/photoprovider.h"
#include <QDebug>

QImage PhotoProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    QStringList temp = id.split('/');

    if(temp.size() > 0)
    {
        QString photoPath;
        QString namePhoto(temp.at(0));
        //QString typePhoto(temp.at(1));

        //qDebug() << "Имя изображения: " << namePhoto << " Сделать из него: " << typePhoto;

        photoPath.append("D:/first_fly/"); // Название изображения
        photoPath.append(namePhoto);

        qDebug() << photoPath;

        QImage image(photoPath);
        image.invertPixels();
        return image;
    }
    //ToDo: Сделать возвращаемое изображение в случае ошибки
}
