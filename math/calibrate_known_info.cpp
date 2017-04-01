#include "calibrate_known_info.h"

Calibrate_known_info::Calibrate_known_info(double plat, double plon, double x, double y)
{
    this->plat = plat;
    this->plon = plon;
    this->x = x;
    this->y = y;
}

Calibrate_known_info::Calibrate_known_info()
{

}

void Calibrate_known_info::setInfo(double plat, double plon, double x, double y){
    this->plat = plat;
    this->plon = plon;
    this->x = x;
    this->y = y;
}

