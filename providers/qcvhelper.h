#ifndef QCVHELPER_H
#define QCVHELPER_H
#include <QImage>
#include <QFile>

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

namespace cvHelper {
    QImage Mat2QImage(const cv::Mat3b &src);
    cv::Mat loadFromQrc(QString qrc, int flag = cv::IMREAD_COLOR);
}


#endif // QCVHELPER_H
