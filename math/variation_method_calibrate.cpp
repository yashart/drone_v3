#include "calibrate_known_info.h"
#include "variation_method_calibrate.h"
#include "math.h"
#include <QDebug>

Variation_method_calibrate::Variation_method_calibrate(QObject *parent):
    QObject(parent)
{
    this->lat = 0;
    this->lon = 0;
    this->infoCount = 0;
    this->tau = 0.000001;
}
double Variation_method_calibrate::functional_lat(Calibrate_known_info info){
    return 2*lat - 2*info.plat + 2*cos(fi)*info.x*offsetX -
            2*sin(fi)*info.y*offsetY;
}

double Variation_method_calibrate::functional_lon(Calibrate_known_info info){
    return 2*lon - 2*info.plon + 2*sin(fi)*info.x*offsetX +
            2*cos(fi)*info.y*offsetY;
}

double Variation_method_calibrate::functional_fi(Calibrate_known_info info){
    return 2*info.plat*sin(fi)*info.x*offsetX+
            2*info.plat*cos(fi)*info.y*offsetY-
            2*sin(fi)*info.x*offsetX*lat -
            2*cos(fi)*lat*info.y*offsetY -
            2*info.plon*cos(fi)*info.x*offsetX +
            2*info.plon*sin(fi)*info.y*offsetY +
            2*cos(fi)*info.x*offsetX*lon-
            2*sin(fi)*info.y*offsetY*lon;
}

double Variation_method_calibrate::functional_offsetX(Calibrate_known_info info){
    return 2*info.x*info.x*offsetX -
            2*info.plat*cos(fi)*info.x +
            2*cos(fi)*info.x*lat -
            2*info.plon*sin(fi)*info.x +
            2*sin(fi)*info.x*lon;
}

double Variation_method_calibrate::functional_offsetY(Calibrate_known_info info)
{
    return 2*info.y*info.y*offsetY +
            2*info.plat*sin(fi)*info.y -
            2*sin(fi)*info.y*lat -
            2*info.plon*cos(fi)*info.y +
            2*cos(fi)*info.y*lon;
}

void Variation_method_calibrate::oneIteration(Calibrate_known_info info){
    this->lat = this->lat - this->tau * functional_lat(info);
    this->lon = this->lon - this->tau * functional_lon(info);
    this->fi = this->fi - this->tau * functional_fi(info);
    this->offsetX = this->offsetX - this->tau * functional_offsetX(info) * 0.1;
    this->offsetY = this->offsetY - this->tau * functional_offsetY(info) * 0.1;
}

void Variation_method_calibrate::calcMethod(){
    for (int j = 0; j < 1000000; j++){
        for (int i = 0; i < this->infoCount; i++){
            oneIteration(this->info[i]);
        }
    }
}

void Variation_method_calibrate::add_info(double plat, double plon, double x, double y)
{
    qDebug() << "add_info: " << plat << plon << x << y << this->tau;
    this->info[this->infoCount].setInfo(plat, plon, x, y);
    this->infoCount += 1;
}

