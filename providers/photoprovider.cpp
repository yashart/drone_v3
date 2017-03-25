#include "providers/photoprovider.h"
#include <QDebug>

QImage PhotoProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    QStringList temp = id.split('/');

    int sz = temp.size();

    if(sz >= 1)
    {
        QString photoPath;
        QString namePhoto(temp.at(0));
        QString typePhoto;
        if (sz >= 2)
            typePhoto = temp.at(1);

        //qDebug() << "Имя изображения: " << namePhoto << " Сделать из него: " << typePhoto;

        photoPath.append("D:/first_fly/"); // Название изображения
        photoPath.append(namePhoto);

        QImage image(photoPath);

        if (typePhoto == "invert")
        {
            qDebug() << "Сработало";
            image.invertPixels();
        }
        return image;
    }
    //QImage ret(":/img/photo_example.jpg");
    return QImage(":/img/photo_example.jpg");
    //ToDo: Сделать возвращаемое изображение в случае ошибки
}
