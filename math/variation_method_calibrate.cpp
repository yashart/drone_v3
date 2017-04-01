#include "variation_method_calibrate.h"
#include "math.h"

Variation_method_calibrate::Variation_method_calibrate(double lat,
                                                           double lon,
                                                           double fi,
                                                           double offsetX,
                                                           double offsetY)
{
    this->lat = lat;
    this->lon = lon;
    this->fi = fi;
    this->offsetX = offsetX;
    this->offsetY = offsetY;
    this->tau = 0.001;
}

double functional_lat(Calibrate_known_info info){
    return 2*lat - 2*info.plat + 2*cos(fi)*info.x*offsetX -
            2*sin(fi)*info.y*offsetY;
}

double functional_lon(Calibrate_known_info info){
    return 2*lon - 2*info.plon + 2*sin(fi)*info.x*offsetX +
            2*cos(fi)*info.y*offsetY;
}

double functional_fi(Calibrate_known_info info){
    return 2*info.plat*sin(fi)*info.x*offsetX+
            2*info.plat*cos(fi)*info.y*offsetY-
            2*sin(fi)*info.x*offsetX*lat -
            2*cos(fi)*lat*info.y*offsetY -
            2*info.plon*cos(fi)*info.x*offsetX +
            2*info.plon*sin(fi)*info.y*offsetY +
            2*cos(fi)*info.x*offsetX*lon-
            2*sin(fi)*info.y*offsetY*lon;
}

double functional_offsetX(Calibrate_known_info info){
    return 2*info.x*info.x*offsetX -
            2*info.plat*cos(fi)*info.x +
            2*cos(fi)*info.x*lat -
            2*info.plon*sin(fi)*info.x +
            2*sin(fi)*info.x*lon;
}

double functional_offsetY(Calibrate_known_info info)
{
    return 2*info.y*info.y*offsetY +
            2*info.plat*sin(fi)*info.y -
            2*sin(fi)*info.y*lat -
            2*info.plon*cos(fi)*info.y +
            2*cos(fi)*info.y*lon;
}

void oneIteration(Calibrate_known_info info){
    this->lat = this->lat - this->tau * functional_lat(info);
    this->lon = this->lon - this->tau * functional_lon(info);
    this->fi = this->fi - this->tau * functional_fi(info);
    this->offsetX = this->offsetX - this->tau * functional_offsetX(info);
    this->offsetY = this->offsetY - this->tau * functional_offsetY(info);
}

void calcMethod(Calibrate_known_info info[], int count){
    for (int i = 0; i < count; i++){
        for (int j = 0; j < 100; j++){
            oneIteration(info[i]);
        }
    }
}
