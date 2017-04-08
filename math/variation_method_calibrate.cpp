#include "calibrate_known_info.h"
#include "variation_method_calibrate.h"
#include "math.h"
#include <QDebug>

Variation_method_calibrate::Variation_method_calibrate(QObject *parent):
    QObject(parent)
{
    this->lat = 0;
    this->lon = 0;
    this->a = 0;
    this->b = 0;
    this->c = 0;
    this->d = 0;
    this->infoCount = 0;
    this->tau = 0.0000001;
    this->fi = 0;
    this->offsetX = 0;
    this->offsetY = 0;
}
double Variation_method_calibrate::functional_lat(Calibrate_known_info info){
    return 2*lat - 2*info.plat + 2*a*info.x -
            2*b*info.y;
}

double Variation_method_calibrate::functional_lon(Calibrate_known_info info){
    return 2*lon - 2*info.plon + 2*c*info.x +
            2*d*info.y;
}

double Variation_method_calibrate::functional_a(Calibrate_known_info info)
{
    return 2*a*info.x*info.x - 2*info.plat*info.x + 2*b*info.x*info.y +
            2*lat*info.x;
}

double Variation_method_calibrate::functional_b(Calibrate_known_info info)
{
    return 2*b*info.y*info.y - 2*info.plat*info.y + 2*a*info.x*info.y +
            2*lat*info.y;
}

double Variation_method_calibrate::functional_c(Calibrate_known_info info)
{
    return 2*c*info.x*info.x - 2*info.plon*info.x + 2*d*info.x*info.y +
            2*lon*info.x;
}

double Variation_method_calibrate::functional_d(Calibrate_known_info info)
{
    return 2*d*info.y*info.y - 2*info.plon*info.y + 2*c*info.x*info.y +
            2*lon*info.y;
}

void Variation_method_calibrate::calcMethod(){
    for (int j = 0; j < 10000000; j++){
        double meanFunctionalLat = 0;
        double meanFunctionalLon = 0;
        double meanFunctionalA = 0;
        double meanFunctionalB = 0;
        double meanFunctionalC = 0;
        double meanFunctionalD = 0;
        for (int i = 0; i < this->infoCount; i++){
            meanFunctionalLat += functional_lat(this->info[i])*this->tau;
            meanFunctionalLon += functional_lon(this->info[i])*this->tau;
            meanFunctionalA += functional_a(this->info[i])*this->tau;
            meanFunctionalB += functional_b(this->info[i])*this->tau;
            meanFunctionalC += functional_c(this->info[i])*this->tau;
            meanFunctionalD += functional_d(this->info[i])*this->tau;

        }
        this->lat -= meanFunctionalLat;
        this->lon -= meanFunctionalLon;
        this->a -= meanFunctionalA;
        this->b -= meanFunctionalB;
        this->c -= meanFunctionalC;
        this->d -= meanFunctionalD;

    }

    this->fi = acos(a/sqrt(a*a + c*c))*360/3.14159265358979323846;
    this->offsetX = sqrt(a*a + c*c);
    this->offsetY = sqrt(b*b + d*d);
    qDebug() << "params: " << fi << offsetX << offsetY;
}

void Variation_method_calibrate::add_info(double plat, double plon, double x, double y)
{
    qDebug() << "add_info: " << plat << plon << x << y << this->tau;
    this->info[this->infoCount].setInfo(plat, plon, x, y);
    this->infoCount += 1;
}

