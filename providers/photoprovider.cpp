#include "providers/photoprovider.h"
#include <QDebug>

/*QImage Mat2QImage(const cv::Mat3b &src) {
    QImage dest(src.cols, src.rows, QImage::Format_ARGB32);
    for (int y = 0; y < src.rows; ++y) {
        const cv::Vec3b *srcrow = src[y];
        QRgb *destrow = (QRgb*)dest.scanLine(y);
        for (int x = 0; x < src.cols; ++x) {
            destrow[x] = qRgba(srcrow[x][2], srcrow[x][1], srcrow[x][0], 255);
        }
    }
    return dest;
}*/

void PhotoProvider::setImage(const QUrl & url)
{
    qDebug() << "Set path: " << url.toLocalFile();
    curImg = cv::imread( url.toLocalFile().toStdString(), 1 );
    snapImg = curImg.clone();
    tempImg = curImg.clone();
}


QImage PhotoProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    QString sUrl(id);
    QTime time;
    time.start();

    sUrl.insert(0, "file:///");


    QUrl url(sUrl);
    QUrlQuery urlQuery(url.query());

    // Если предыдущий путь отличается от текущего загружаем новое изображение

    if ( url.toLocalFile() != curImgPath.toLocalFile() )
    {
        qDebug() << "Hello";
        setImage(url);
        curImgPath = url;
    }


    // нажали кнопку "инверсия изображения"


    // Если послана команда "подтвердить сохранение"

    if(urlQuery.hasQueryItem("temp") != true)
    {

        // загрузить оригинальное изображение в память

        if(urlQuery.hasQueryItem("standart") == true)
        {
            snapImg = curImg.clone();
        }


        // инверсия цветов

        if (urlQuery.hasQueryItem("invert") == true)
        {
            cv::bitwise_not ( snapImg, snapImg );
        }

        if (urlQuery.hasQueryItem("contrast") == true)
        {
            double alpha = urlQuery.queryItemValue("contrast").toDouble();
            int beta = 0;

            double preCalc[256];

            for (int i = 0; i <= 255; i++)
            {
                preCalc[i] =  (alpha * i) + beta ;
            }


            for( int y = 0; y < snapImg.rows; y++ )
            {
                for( int x = 0; x < snapImg.cols; x++ )
                {
                    for( int c = 0; c < 3; c++ )
                    {
                        snapImg.at<cv::Vec3b>(y,x)[c] =
                                cv::saturate_cast<uchar>( preCalc[snapImg.at<cv::Vec3b>(y,x)[c]] );
                    }
                }
            }
        }

        if (urlQuery.hasQueryItem("brightness") == true)
        {
            double alpha = 1;
            int beta = urlQuery.queryItemValue("brightness").toDouble();

            double preCalc[256];

            for (int i = 0; i <= 255; i++)
            {
                preCalc[i] =  (alpha * i) + beta ;
            }


            for( int y = 0; y < snapImg.rows; y++ )
            {
                for( int x = 0; x < snapImg.cols; x++ )
                {
                    for( int c = 0; c < 3; c++ )
                    {
                        snapImg.at<cv::Vec3b>(y,x)[c] =
                                cv::saturate_cast<uchar>( preCalc[snapImg.at<cv::Vec3b>(y,x)[c]] );
                    }
                }
            }
        }

        if (urlQuery.hasQueryItem("gamma") == true)
        {
            double gamma = urlQuery.queryItemValue("gamma").toDouble();
            double G = 1/gamma;

            double preCalc[256];

            for (int i = 0; i <= 255; i++)
            {
                preCalc[i] =  pow((i / 255.0), G) * 255 ;
            }


            for( int y = 0; y < snapImg.rows; y++ )
            {
                for( int x = 0; x < snapImg.cols; x++ )
                {
                    for( int c = 0; c < 3; c++ )
                    {
                        snapImg.at<cv::Vec3b>(y,x)[c] =
                                cv::saturate_cast<uchar>( preCalc[snapImg.at<cv::Vec3b>(y,x)[c]] );
                    }
                }
            }
        }

        QImage image;

        if (urlQuery.hasQueryItem("red")
                || urlQuery.hasQueryItem("green")
                || urlQuery.hasQueryItem("blue")) // обработка каналов
        {
            cv::Mat channels = snapImg.clone();
            for( int c = 0; c < 3; c++ ) // 0 =blue ; 1 = green ; 2=red
            {
                if(urlQuery.hasQueryItem("red") && c == 2)
                {
                    qDebug() << "red";
                    continue;
                }
                if(urlQuery.hasQueryItem("green") && c == 1)
                {
                    qDebug() << "green";
                    continue;
                }
                if(urlQuery.hasQueryItem("blue") && c == 0)
                {
                    qDebug() << "blue";
                    continue;
                }

                for( int y = 0; y < snapImg.rows; y++ )
                {
                    for( int x = 0; x < snapImg.cols; x++ )
                    {
                        channels.at<cv::Vec3b>(y,x)[c] = cv::saturate_cast<uchar>(0);
                    }
                }
            }
            image  =  cvHelper::Mat2QImage(channels);
            qDebug() << time.elapsed();
            return image;

        }

        image  = cvHelper::Mat2QImage(snapImg);
        qDebug() << time.elapsed();
        return image;
    }


    // Если мы просто играемся ползунком

    else
    {

        if (urlQuery.hasQueryItem("contrast") == true)
        {
            double alpha = urlQuery.queryItemValue("contrast").toDouble();
            int beta = 0;

            double preCalc[256];

            for (int i = 0; i <= 255; i++)
            {
                preCalc[i] =  (alpha * i) + beta ;
            }


            for( int y = 0; y < snapImg.rows; y++ )
            {
                for( int x = 0; x < snapImg.cols; x++ )
                {
                    for( int c = 0; c < 3; c++ )
                    {
                        tempImg.at<cv::Vec3b>(y,x)[c] =
                                cv::saturate_cast<uchar>( preCalc[snapImg.at<cv::Vec3b>(y,x)[c]] );
                    }
                }
            }
        }


        if (urlQuery.hasQueryItem("brightness") == true)
        {
            double alpha = 1;
            int beta = urlQuery.queryItemValue("brightness").toDouble();

            double preCalc[256];

            for (int i = 0; i <= 255; i++)
            {
                preCalc[i] =  (alpha * i) + beta ;
            }


            for( int y = 0; y < snapImg.rows; y++ )
            {
                for( int x = 0; x < snapImg.cols; x++ )
                {
                    for( int c = 0; c < 3; c++ )
                    {
                        tempImg.at<cv::Vec3b>(y,x)[c] =
                                cv::saturate_cast<uchar>( preCalc[snapImg.at<cv::Vec3b>(y,x)[c]] );
                    }
                }
            }
        }


        if (urlQuery.hasQueryItem("gamma") == true)
        {
            double gamma = urlQuery.queryItemValue("gamma").toDouble();
            double G = 1/gamma;

            double preCalc[256];

            for (int i = 0; i <= 255; i++)
            {
                preCalc[i] =  pow((i / 255.0), G) * 255 ;
            }


            for( int y = 0; y < snapImg.rows; y++ )
            {
                for( int x = 0; x < snapImg.cols; x++ )
                {
                    for( int c = 0; c < 3; c++ )
                    {
                        tempImg.at<cv::Vec3b>(y,x)[c] =
                                cv::saturate_cast<uchar>( preCalc[snapImg.at<cv::Vec3b>(y,x)[c]] );
                    }
                }
            }
        }

        QImage image;

        if (urlQuery.hasQueryItem("red")
                || urlQuery.hasQueryItem("green")
                || urlQuery.hasQueryItem("blue")) // обработка каналов
        {
            cv::Mat channels = snapImg.clone();
            for( int c = 0; c < 3; c++ ) // 0 =blue ; 1 = green ; 2=red
            {
                if(urlQuery.hasQueryItem("red") && c == 2)
                {
                    qDebug() << "red";
                    continue;
                }
                if(urlQuery.hasQueryItem("green") && c == 1)
                {
                    qDebug() << "green";
                    continue;
                }
                if(urlQuery.hasQueryItem("blue") && c == 0)
                {
                    qDebug() << "blue";
                    continue;
                }

                for( int y = 0; y < snapImg.rows; y++ )
                {
                    for( int x = 0; x < snapImg.cols; x++ )
                    {
                        channels.at<cv::Vec3b>(y,x)[c] = cv::saturate_cast<uchar>(0);
                    }
                }
            }
            image  =  cvHelper::Mat2QImage(channels);
            qDebug() << time.elapsed();
            return image;
        }

        image  = cvHelper::Mat2QImage(tempImg);
        qDebug() << time.elapsed();
        return image;

    }
}

    /*
    if (sz >= 2)
        typePhoto = temp.at(1);

    cv::Mat snapImg = curImg.clone();

    photoPath.append("D:/tracks/first_fly/"); // Название изображения
    // D:/first_fly/
    // /home/yashart/Downloads/first_fly/
    photoPath.append(namePhoto);

    //QImage image(photoPath);

    if (typePhoto == "invert") // инверсия цветов
    {
        bitwise_not ( snapImg, snapImg );
    }
    if (typePhoto == "contrast")
    {
        double alpha = 1;
        int beta = 100;

        double preCalc[256];

        for (int i = 0; i <= 255; i++)
        {
            preCalc[i] =  (alpha * i) + beta ;
        }


        for( int y = 0; y < snapImg.rows; y++ )
        {
            for( int x = 0; x < snapImg.cols; x++ )
            {
                for( int c = 0; c < 3; c++ )
                {
                    snapImg.at<cv::Vec3b>(y,x)[c] =
                            cv::saturate_cast<uchar>( preCalc[snapImg.at<cv::Vec3b>(y,x)[c]] );
                }
            }
        }
    }
    if (typePhoto == "gamma")
    {
        QTime time;
        time.start();
        double gamma = 0.5;
        double G = 1/gamma;

        double preCalc[256];

        for (int i = 0; i <= 255; i++)
        {
            preCalc[i] =  pow((i / 255.0), G) * 255 ;
        }


        for( int y = 0; y < snapImg.rows; y++ )
        {
            for( int x = 0; x < snapImg.cols; x++ )
            {
                for( int c = 0; c < 3; c++ )
                {
                    snapImg.at<cv::Vec3b>(y,x)[c] =
                            cv::saturate_cast<uchar>( preCalc[snapImg.at<cv::Vec3b>(y,x)[c]] );
                }
            }
        }
        qDebug() << time.elapsed();
    }

    size->setWidth(snapImg.cols);
    size->setHeight(snapImg.rows);

    QImage image;
    image  = Mat2QImage(snapImg);
    return image;
    //QImage ret(":/img/photo_example.jpg");
    return QImage(":/img/photo_example.jpg");
    //ToDo: Сделать возвращаемое изображение в случае ошибки
    */
