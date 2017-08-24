#include "gps_handler.h"

// MAVLink
#include <mavlink_v1/ardupilotmega/mavlink.h>

// Qt
#include <QtMath>
#include <QDebug>
#include <QFile>

using namespace domain;

GpsHandler::GpsHandler(MavLinkCommunicator* communicator):
    AbstractHandler(communicator)
{
    this->startTimer(2000); // 1 Hz
}

void GpsHandler::processMessage(const mavlink_message_t& message)
{
    if (message.msgid != MAVLINK_MSG_ID_GLOBAL_POSITION_INT ||
        message.sysid == 0) return;

    mavlink_global_position_int_t gps;
    mavlink_msg_global_position_int_decode(&message, &gps);

    QFile file("gps.txt");
    if (!file.open(QIODevice::WriteOnly))
            return;

    QTextStream in(&file);

    //aircraftAxes.setPitch(qRadiansToDegrees(attitude.pitch));
    in << gps.lat * 0.1 / 1E6
             << " " << gps.lon * 0.1 / 1E6
             << " " << gps.alt * 0.1 / 1E6;

    file.close();
}
