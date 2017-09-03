#include "missionmodel.h"
#include "QProcess"
#include "mavlink_communicator.h"
#include "unistd.h"

MissionModel::MissionModel(domain::MavLinkCommunicator* communicator, domain::SerialLink* link, QObject *parent):
    QObject(parent)
{
    this->communicator = communicator;
    this->link = link;
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
    if (!file.open(QIODevice::WriteOnly))
        return;

     QTextStream out(&file);
     out << "QGC WPL 110\n";
     for (int i = 0; i < this->m_missionList.size(); i++)
     {
        QGeoCoordinate coord(this->missionList().at(i).value<QGeoCoordinate>());
        if (i == 0){
            out << i << "\t" << "1" << "\t" << "3\t" << "16"
                                             << "\t" << "0\t5\t0\t0\t" << coord.latitude()
                                             << "\t" << coord.longitude()
                                             << "\t" << coord.altitude()
                                             << "\t" << "1\n";

        } else if (i == 1){
            out << i << "\t" << "0" << "\t" << "3\t" << "22"
                                             << "\t" << "0\t5\t0\t0\t" << coord.latitude()
                                             << "\t" << coord.longitude()
                                             << "\t" << coord.altitude()
                                             << "\t" << "1\n";
        } else if (i == this->m_missionList.size() - 1){
            out << i << "\t" << "0" << "\t" << "3\t" << "20"
                                             << "\t" << "0\t5\t0\t0\t" << coord.latitude()
                                             << "\t" << coord.longitude()
                                             << "\t" << coord.altitude()
                                             << "\t" << "1\n";
        }else {
            out << i << "\t" << "0" << "\t" << "3\t" << "16"
                                             << "\t" << "0\t5\t0\t0\t" << coord.latitude()
                                             << "\t" << coord.longitude()
                                             << "\t" << coord.altitude()
                                             << "\t" << "1\n";
        }
     }
     QProcess p;
     QStringList params;
     this->communicator->removeLink(link);
     params << "mission.py";
     //sleep(30);
     p.setWorkingDirectory("/home/yashart/Documents/Programming/drone_v3/build-drone_v3-Desktop_Qt_5_9_0_GCC_64bit-Debug/");
     p.start("python mission.py");
     p.waitForFinished(-1);
     //sleep(30);
     qDebug() << "----------------------";
     qDebug() << p.readAll();
     this->communicator->addLink(link, MAVLINK_COMM_0);
}
