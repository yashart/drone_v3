#ifndef GPS_HANDLER_H
#define GPS_HANDLER_H

#include "abstract_handler.h"

namespace domain
{
    class GpsHandler: public AbstractHandler
    {
        Q_OBJECT

    public:
        GpsHandler(MavLinkCommunicator* communicator);

    public slots:
        void processMessage(const mavlink_message_t& message) override;
    };
}

#endif // GPS_HANDLER_H
