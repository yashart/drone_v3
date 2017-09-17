#include "calibrate_known_info.h"
#include "variation_method_calibrate.h"
#include "math.h"
#include <QDebug>
#include <QList>

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
    this->tau = 0.0000005;
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
    QList <double> meanA;
    QList <double> meanB;
    QList <double> meanC;
    QList <double> meanD;
    QList <double> meanLat;
    QList <double> meanLon;

    for (int i1 = 0; i1 < this->infoCount; i1++){
        for (int i2 = 0; i2 < i1; i2++){
            for (int i3 = 0; i3 < i2; i3++){
                Calibrate_known_info point1 = this->info[i1];
                Calibrate_known_info point2 = this->info[i2];
                Calibrate_known_info point3 = this->info[i3];
                double b = ((point1.plat - point3.plat)/(point1.x - point3.x) -
                            (point2.plat - point3.plat)/(point2.x - point3.x)) /
                        ((point1.y - point3.y)/(point1.x - point3.x) -
                         (point2.y - point3.y)/(point2.x - point3.x));
                double d = ((point1.plon - point3.plon)/(point1.x - point3.x) -
                            (point2.plon - point3.plon)/(point2.x - point3.x)) /
                        ((point1.y - point3.y)/(point1.x - point3.x) -
                         (point2.y - point3.y)/(point2.x - point3.x));
                double a = (point2.plat - point3.plat)/(point2.x - point3.x) -
                        b * (point2.y - point3.y)/(point2.x - point3.x);
                double c = (point2.plon - point3.plon)/(point2.x - point3.x) -
                        d * (point2.y - point3.y)/(point2.x - point3.x);
                double lat = point1.plat - a * point1.x - b * point1.y;
                double lon = point1.plon - c * point1.x - d * point1.y;
                meanA.append(a);
                meanB.append(b);
                meanC.append(c);
                meanD.append(d);
                meanLat.append(lat);
                meanLon.append(lon);
            }
        }
    }
    this->a = 0;
    this->b = 0;
    this->c = 0;
    this->d = 0;
    this->lat = 0;
    this->lon = 0;
    for (int i = 0; i < meanA.length(); i++)
    {
        this->a += meanA[i] * meanA[i];
        this->b += meanB[i] * meanB[i];
        this->c += meanC[i] * meanC[i];
        this->d += meanD[i] * meanD[i];
        this->lat += meanLat[i] * meanLat[i];
        this->lon += meanLon[i] * meanLon[i];
    }
    this->a = sqrt(this->a)/sqrt(meanA.length());
    this->b = sqrt(this->b)/sqrt(meanB.length());
    this->c = sqrt(this->c)/sqrt(meanC.length());
    this->d = sqrt(this->d)/sqrt(meanD.length());
    this->lat = sqrt(this->lat)/sqrt(meanLat.length());
    this->lon = sqrt(this->lon)/sqrt(meanLon.length());
    qDebug() << lat << lon << a << b << c << d;
    this->calcMethodNewton();

    this->fi = acos(c/sqrt(a*a + c*c))*180/3.14159265358979323846;
    this->offsetX = sqrt(a*a + c*c);
    this->offsetY = sqrt(b*b + d*d);
    qDebug() << "params: " << fi << offsetX << offsetY;
}

void Variation_method_calibrate::calcMethodNewton()
{
    for (int j = 0; j < 1000; j++){
        double meanFunctionalA = 0;
        double meanFunctionalB = 0;
        double meanFunctionalC = 0;
        double meanFunctionalD = 0;
        double meanFunctionalLat = 0;
        double meanFunctionalLon = 0;
        for (int i = 0; i < this->infoCount; i++){
            meanFunctionalA += functional_a(this->info[i])*this->tau;
            meanFunctionalB += functional_b(this->info[i])*this->tau;
            meanFunctionalC += functional_c(this->info[i])*this->tau;
            meanFunctionalD += functional_d(this->info[i])*this->tau;
            meanFunctionalLat += functional_lat(this->info[i])*this->tau*100;
            meanFunctionalLon += functional_lon(this->info[i])*this->tau*100;
        }
        this->a -= meanFunctionalA;
        this->b -= meanFunctionalB;
        this->c -= meanFunctionalC;
        this->d -= meanFunctionalD;
        this->lat -= meanFunctionalLat;
        this->lon -= meanFunctionalLon;
        qDebug() << lat << lon << a << b << c << d;
    }
}

void Variation_method_calibrate::add_info(double plat, double plon, double x, double y)
{
    qDebug() << "add_info: " << plat << plon << x << y << this->tau;
    this->info[this->infoCount].setInfo(plat, plon, x, y);
    this->infoCount += 1;
}

