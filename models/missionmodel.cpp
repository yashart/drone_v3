#include "missionmodel.h"
#include "QProcess"

MissionModel::MissionModel(QObject *parent):
    QObject(parent)
{

}
void MissionModel::addPoint(QGeoCoordinate point)
{
    qDebug() << point.latitude() << " " << point.longitude() << " " << point.altitude() << endl;
    double lat = point.latitude();
    double lon = point.longitude();
    double alt = point.altitude();
    this->m_missionList.append(QVariant::fromValue
                             (QGeoCoordinate(lat, lon, alt)));
    qDebug() << QVariant::fromValue
                (QGeoCoordinate(lat, lon, alt));
    emit missionListChanged();
    emit startPointChanged();
    emit finishPointChanged();
}

void MissionModel::delPoint()
{
    if (!this->m_missionList.empty())
    {
        this->m_missionList.pop_back();
    }

    emit missionListChanged();
    emit startPointChanged();
    emit finishPointChanged();
}

void MissionModel::makeMision()
{
    QFile file("mpmission.txt");
    if (!file.open(QIODevice::ReadWrite))
        return;

     QTextStream out(&file);
     out << "QGC WPL 110\n";
     for (int i = 0; i < this->m_missionList.size(); i++)
     {
        QGeoCoordinate coord(this->missionList().at(i).value<QGeoCoordinate>());
        if (i == 0){
            out << i << "\t" << "1" << "\t" << "0\t" << "16"
                                             << "\t" << "0\t0\t0\t0\t" << coord.latitude()
                                             << "\t" << coord.longitude()
                                             << "\t" << coord.altitude()
                                             << "\t" << "1\n";

        }else {
            out << i << "\t" << "0" << "\t" << "3\t" << "16"
                                             << "\t" << "0\t0\t0\t0\t" << coord.latitude()
                                             << "\t" << coord.longitude()
                                             << "\t" << coord.altitude()
                                             << "\t" << "1\n";
        }
     }
     QProcess p;
     QStringList params;

     params << "mission.py";
     p.start("python", params);
     p.waitForFinished(-1);
     qDebug() << p.readAll();
}
