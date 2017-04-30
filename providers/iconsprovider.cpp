#include "iconsprovider.h"
#include <QDebug>


QImage IconProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
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

        cv::Mat icon;

        QString imageName;
        imageName = QString(":/img/popupIconsSet/points/%1.png").arg(typeFigure);

        icon = cvHelper::loadFromQrc(imageName);

        cv::Vec3b setColor(0,0,0);

        if (colorFigure == "red") // 0 = blue 1=green 2=red
        {
            setColor[0] = 0; setColor[1] = 0; setColor[2] = 255;
        }
        if (colorFigure == "green")
        {
            setColor[0] = 0; setColor[1] = 200; setColor[2] = 0;
        }
        if (colorFigure == "black")
        {
            setColor[0] = 0; setColor[1] = 0; setColor[2] = 0;
        }
        if (colorFigure == "yellow")
        {
            setColor[0] = 0; setColor[1] = 230; setColor[2] = 200;
        }
        if (colorFigure == "blue")
        {
            setColor[0] = 255; setColor[1] = 0; setColor[2] = 0;
        }

        for(int y=0;y<icon.rows;y++)
        {
            for(int x=0;x<icon.cols;x++)
            {
                cv::Vec3b color(0,0,0);

               // get pixel
                cv::Vec3b checkedColor = icon.at<cv::Vec3b>(cv::Point(x,y));

                // set pixel
                if(color == checkedColor)
                icon.at<cv::Vec3b>(cv::Point(x,y)) = setColor;
            }
        }

        QImage image;

        image = cvHelper::Mat2QImage(icon);

        return image;
    }
}
