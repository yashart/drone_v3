#include "telemetry.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>

Telemetry::Telemetry(QObject *parent) : QObject(parent)
{
    this->pitch = 0;
    this->row = 0;
    this->yaw = 0;
}

void Telemetry::readAxes()
{
    QFile file("aircraftAxes.txt");
    if (!file.open(QIODevice::ReadOnly))
            return;

    QTextStream in(&file);
    QString line = in.readLine();
    QStringList fields = line.split(" ");
    this->pitch = fields[0].toDouble();
    this->row = fields[1].toDouble();
    this->yaw = fields[2].toDouble();
    emit pitchChanged();
    emit rowChanged();
    emit yawChanged();
    //aircraftAxes.setPitch(qRadiansToDegrees(attitude.pitch));

    file.close();
}

void Telemetry::readGps()
{
    QFile file("gps.txt");
    if (!file.open(QIODevice::ReadOnly))
            return;

    QTextStream in(&file);
    QString line = in.readLine();
    QStringList fields = line.split(" ");
    this->lat = fields[0].toDouble();
    this->lon = fields[1].toDouble();
    this->alt = fields[2].toDouble();
    emit latChanged();
    emit lonChanged();
    emit altChanged();
    //aircraftAxes.setPitch(qRadiansToDegrees(attitude.pitch));

    file.close();
}
