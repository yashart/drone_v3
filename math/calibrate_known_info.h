#ifndef CALIBRATE_KNOWN_INFO_H
#define CALIBRATE_KNOWN_INFO_H


class Calibrate_known_info
{
public:
    double plat;
    double plon;
    double x;
    double y;

public:
    Calibrate_known_info(double plat,
                         double plon,
                         double x,
                         double y);
    Calibrate_known_info();
    void setInfo(double plat,
            double plon,
            double x,
            double y);
};

#endif // CALIBRATE_KNOWN_INFO_H
