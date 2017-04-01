#ifndef VARIATION_METHOD_CALIBRATE_H
#define VARIATION_METHOD_CALIBRATE_H
#include "calibrate_known_info.h"
#include <QObject>
#include <math.h>


class Variation_method_calibrate : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double lat READ getLat WRITE setLat)
    Q_PROPERTY(double lon READ getLon WRITE setLon)
    Q_PROPERTY(double fi READ getFi WRITE setFi)
    Q_PROPERTY(double offsetX READ getOffsetX WRITE setOffsetX)
    Q_PROPERTY(double offsetY READ getOffsetY WRITE setOffsetY)


public:
    Variation_method_calibrate(QObject *parent = 0);
    double getLat(){
        return this->lat;
    }
    void setLat(const double &lat){
        this->lat = lat;
    }

    double getLon(){
        return this->lon;
    }
    void setLon(const double &lon){
        this->lon = lon;
    }

    double getFi(){
        return this->fi;
    }
    void setFi(const double &fi){
        this->fi = fi;
    }

    double getOffsetX(){
        return this->offsetX;
    }
    void setOffsetX(const double &offsetX){
        this->offsetX = offsetX;
    }

    double getOffsetY(){
        return this->offsetY;
    }
    void setOffsetY(const double &offsetY){
        this->offsetY = offsetY;
    }

private:
    double lat;
    double lon;
    double fi;
    double offsetX;
    double offsetY;
    double tau;
    Calibrate_known_info info[100];
    int infoCount;
public:
    Q_INVOKABLE void oneIteration(Calibrate_known_info info);
    Q_INVOKABLE void calcMethod();
    Q_INVOKABLE double functional_lat(Calibrate_known_info info);
    Q_INVOKABLE double functional_lon(Calibrate_known_info info);
    Q_INVOKABLE double functional_fi(Calibrate_known_info info);
    Q_INVOKABLE double functional_offsetX(Calibrate_known_info info);
    Q_INVOKABLE double functional_offsetY(Calibrate_known_info info);
    Q_INVOKABLE void add_info(double plat, double plon, double x, double y);
};
#endif // VARIATION_METHOD_CALIBRATE_H
