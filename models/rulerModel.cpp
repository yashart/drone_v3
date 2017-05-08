#include "rulerModel.h"


RulerModel::RulerModel(QObject *parent):
    QObject(parent)
{
    this->dist_to_mouse = 0;
    this->azimuth = 0;

}
void RulerModel::addPoint(QGeoCoordinate point)
{
    qDebug() << point.latitude() << " " << point.longitude() << endl;
    double lat = point.latitude();
    double lon = point.longitude();
    this->m_rulerList.append(QVariant::fromValue
                             (QGeoCoordinate(lat, lon)));
    emit rulerListChanged();
    emit startPointChanged();
    emit finishPointChanged();
    emit distanceChanged();
}

void RulerModel::delPoint()
{
    if (!this->m_rulerList.empty())
    {
        this->m_rulerList.pop_back();
    }
    if (this->m_rulerList.empty())
    {
        this->dist_to_mouse = 0;
        this->last_sum = 0;
        this->azimuth = 0;
    }

    emit rulerListChanged();
    emit startPointChanged();
    emit finishPointChanged();
    emit distanceChanged();
}

QVariant RulerModel::distance()
{
    double sum = 0;
    for (int i = 1; i < this->rulerList().size(); i++)
    {
        QGeoCoordinate one(this->rulerList().at(i-1).value<QGeoCoordinate>());
        QGeoCoordinate two(this->rulerList().at(i).value<QGeoCoordinate>());
        sum += one.distanceTo(two);
    }
    this->last_sum = sum;
    return QVariant(QString::number(sum).append(" м"));
}

double RulerModel::distanceBetween(QGeoCoordinate point1, QGeoCoordinate point2)
{
    return point1.distanceTo(point2);
}


void RulerModel::distanceToMouse(QGeoCoordinate point)
{
    double sum = 0;

    int size = this->rulerList().size();
    if (size > 0)
    {
        QGeoCoordinate last_point(this->rulerList().at(size-1).value<QGeoCoordinate>());
        sum +=  this->last_sum + last_point.distanceTo(point);
        this->dist_to_mouse = sum;

        if (size >= 2) // Если уже установленно две и более точек измеряем улог, образованный тремя последними точками
        {
            QGeoCoordinate pre_last_point(this->rulerList().at(size-2).value<QGeoCoordinate>()); // предпоследняя точка
            this->azimuth = qAbs(last_point.azimuthTo(point) - last_point.azimuthTo(pre_last_point));
        }
        else
        {
            this->azimuth = last_point.azimuthTo(point);
        }
    }

    emit checkPointChanged();
}

QVariant RulerModel::checkPoint()
{
    QString retStr(QString::number(floor(this->dist_to_mouse)));
    retStr.append(" м\n");
    retStr.append(QString::number(floor(this->azimuth)));
    retStr.append(" град\n");
    return QVariant(retStr);
}
