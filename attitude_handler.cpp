#include "attitude_handler.h"

// MAVLink
#include <mavlink_v1/ardupilotmega/mavlink.h>

// Qt
#include <QtMath>
#include <QDebug>
#include <QFile>

using namespace domain;

AttitudeHandler::AttitudeHandler(MavLinkCommunicator* communicator):
    AbstractHandler(communicator)
{
    this->startTimer(2000); // 1 Hz
}

void AttitudeHandler::processMessage(const mavlink_message_t& message)
{
    if (message.msgid != MAVLINK_MSG_ID_ATTITUDE ||
        message.sysid == 0) return;

    mavlink_attitude_t attitude;
    mavlink_msg_attitude_decode(&message, &attitude);
    QFile file("aircraftAxes.txt");
    if (!file.open(QIODevice::WriteOnly))
            return;

    QTextStream in(&file);

    //aircraftAxes.setPitch(qRadiansToDegrees(attitude.pitch));
    in << qRadiansToDegrees(attitude.pitch)
             << " " << qRadiansToDegrees(attitude.roll)
             << " " << qRadiansToDegrees(attitude.yaw);

    file.close();
}
