#ifndef MISSIONMODEL_H
#define MISSIONMODEL_H

#include <QAbstractListModel>
#include <QList>
#include <QGeoCoordinate>
#include <QDebug>
#include <math.h>

class MissionModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList missionList READ missionList NOTIFY missionListChanged)
    Q_PROPERTY(QVariant startPoint READ startPoint NOTIFY startPointChanged)
    Q_PROPERTY(QVariant finishPoint READ finishPoint NOTIFY finishPointChanged)
public:
    MissionModel(QObject *parent = 0);
    QVariantList missionList()
    {
        return this->m_missionList;
    }
    QVariant startPoint()
    {
        if(!this->m_missionList.empty())
        {
            return this->m_missionList.first();
        }
        return QVariant::fromValue(QGeoCoordinate(34.0, -42.0));
    }

    QVariant finishPoint()
    {
        if(this->m_missionList.size() > 1)
        {
            return this->m_missionList.last();
        }

        return QVariant::fromValue(QGeoCoordinate(34.0, -42.0)); // убрать в океан
    }
    Q_INVOKABLE void addPoint(QGeoCoordinate point);
    Q_INVOKABLE void delPoint();
    Q_INVOKABLE void makeMision();

signals:
    void missionListChanged();
    void startPointChanged();
    void finishPointChanged();

private:
    QVariantList m_missionList;
};

#endif // MISSIONMODEL_H
