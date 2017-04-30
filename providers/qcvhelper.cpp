#include "qcvhelper.h"

namespace cvHelper {
    QImage Mat2QImage(const cv::Mat3b &src) {
        QImage dest(src.cols, src.rows, QImage::Format_ARGB32);
        for (int y = 0; y < src.rows; ++y) {
            const cv::Vec3b *srcrow = src[y];
            QRgb *destrow = (QRgb*)dest.scanLine(y);
            for (int x = 0; x < src.cols; ++x) {
                destrow[x] = qRgba(srcrow[x][2], srcrow[x][1], srcrow[x][0], 255);
            }
        }
        return dest;
    }

    cv::Mat loadFromQrc(QString qrc, int flag)
    {
        //double tic = double(getTickCount());

        QFile file(qrc);
        cv::Mat m;
        if(file.open(QIODevice::ReadOnly))
        {
            qint64 sz = file.size();
            std::vector<uchar> buf(sz);
            file.read((char*)buf.data(), sz);
            m = cv::imdecode(buf, flag);
        }

        //double toc = (double(getTickCount()) - tic) * 1000.0 / getTickFrequency();
        //qDebug() << "OpenCV loading time: " << toc;

        return m;
    }
}

