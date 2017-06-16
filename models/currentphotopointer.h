#ifndef CURRENTPHOTOPOINTER_H
#define CURRENTPHOTOPOINTER_H

#include <QObject>
#include <QAbstractListModel>

class CurrentPoint
{
public:
    CurrentPoint(int track_id, double lat, double lon, const QString clr);

    int track_id() const;
    double lat() const;
    double lon() const;
    QString color() const;

    void track_id(int id);
    void lat(double lat);
    void lon(double lon);
    void color(QString clr);

private:
    int m_track_id;
    double m_lat;
    double m_lon;
    QString m_color;
};


class CurrentPhotoPointer : public QAbstractListModel
{
    Q_OBJECT
public:
    enum PointRoles {
        IdRole = Qt::UserRole + 1,
        LatRole,
        LonRole,
        ColorRole
    };

    CurrentPhotoPointer(QObject *parent = 0);


    Q_INVOKABLE void addPointer(int track_id, double lat, double lon, const QString clr);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    QVariant headerData(int section, Qt::Orientation orientation,
                        int role = Qt::DisplayRole) const;

    Qt::ItemFlags flags(const QModelIndex &index) const;

    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole);


protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QList<CurrentPoint> m_points;
};




#endif // CURRENTPHOTOPOINTER_H
