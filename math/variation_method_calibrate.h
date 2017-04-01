#ifndef VARIATION_METHOD_CALIBRATE_H
#define VARIATION_METHOD_CALIBRATE_H
#include "calibrate_known_info.h"


class Variation_method_calibrate
{
private:
    double lat;
    double lon;
    double fi;
    double offsetX;
    double offsetY;
    double tau;

public:
    void oneIteration(Calibrate_known_info info);
    void calcMethod(Calibrate_known_info info[], int count);
    Variation_method_calibrate(double lat,
                               double lon,
                               double fi,
                               double offsetX,
                               double offsetY);
    double functional_lat(Calibrate_known_info info);
    double functional_lon(Calibrate_known_info info);
    double functional_fi(Calibrate_known_info info);
    double functional_offsetX(Calibrate_known_info info);
    double functional_offsetY(Calibrate_known_info info);

};

#endif // VARIATION_METHOD_CALIBRATE_H
