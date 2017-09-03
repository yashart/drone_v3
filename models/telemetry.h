#ifndef TELEMETRY_H
#define TELEMETRY_H

#include <QObject>

class Telemetry : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double pitch READ getPitch WRITE setPitch NOTIFY pitchChanged)
    Q_PROPERTY(double row READ getRow WRITE setRow NOTIFY rowChanged)
    Q_PROPERTY(double yaw READ getYaw WRITE setYaw NOTIFY yawChanged)
    Q_PROPERTY(double lat READ getLat WRITE setLat NOTIFY latChanged)
    Q_PROPERTY(double lon READ getLon WRITE setLon NOTIFY lonChanged)
    Q_PROPERTY(double alt READ getAlt WRITE setAlt NOTIFY altChanged)
public:
    explicit Telemetry(QObject *parent = nullptr);
    double getPitch(){
        return this->pitch;
    }
    void setPitch(const double &pitch){
        this->pitch = pitch;
    }
    double getRow(){
        return this->row;
    }
    void setRow(const double &row){
        this->row = row;
    }
    double getYaw(){
        return this->yaw;
    }
    void setYaw(const double &yaw){
        this->yaw = yaw;
    }
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
    double getAlt(){
        return this->alt;
    }
    void setAlt(const double &alt){
        this->alt = alt;
    }

    Q_INVOKABLE void readAxes();
    Q_INVOKABLE void readGps();
signals:
    void pitchChanged();
    void rowChanged();
    void yawChanged();
    void latChanged();
    void lonChanged();
    void altChanged();
public slots:

private:    
    double pitch;
    double row;
    double yaw;
    double lat;
    double lon;
    double alt;
};

#endif // TELEMETRY_H
