#include "rulerModel.h"
#include <QDebug>

RulerModel::RulerModel(QObject *parent):
    QObject(parent)
{
    this -> dist_to_mouse = 0;

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
    return QVariant(QString::number(sum).append(" метров"));
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
    }

    emit checkPointChanged();
}

QVariant RulerModel::checkPoint()
{
    return QVariant(QString::number(this->dist_to_mouse).append(" метров"));
}
