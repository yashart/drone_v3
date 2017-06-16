#include "currentphotopointer.h"
#include <QDebug>


CurrentPoint::CurrentPoint(int track_id, double lat, double lon, const QString clr)
    : m_track_id(track_id), m_lat(lat), m_lon(lon), m_color(clr)
{
}

int CurrentPoint::track_id() const
{
    return m_track_id;
}

double CurrentPoint::lat() const
{
    return m_lat;
}

double CurrentPoint::lon() const
{
    return m_lon;
}

QString CurrentPoint::color() const
{
    return m_color;
}

void CurrentPoint::track_id(int id)
{
    this->m_track_id = id;
}

void CurrentPoint::lat(double lat)
{
    this->m_lat = lat;
}

void CurrentPoint::lon(double lon)
{
    this->m_lon = lon;
}

void CurrentPoint::color(QString clr)
{
    this->m_color = clr;
}

CurrentPhotoPointer::CurrentPhotoPointer(QObject *parent)
    : QAbstractListModel(parent)
{
}

void CurrentPhotoPointer::addPointer(int track_id, double lat, double lon, const QString clr)
{
    CurrentPoint * pointer = new CurrentPoint(track_id, lat, lon, clr);




    bool isChange = false;

    for (int i = 0; i< m_points.size(); i++)
    {
        bool isExist = m_points.at(i).track_id() == track_id;

        if (isExist)
        {
            m_points[i].track_id(track_id);
            m_points[i].lat(lat);
            m_points[i].lon(lon);
            m_points[i].color(clr);
            isChange = true;
            emit dataChanged(index(0, 0), index(rowCount(), 0));
            qDebug() << rowCount();

            qDebug() << "Изменен указатель. Трек: " << track_id << " Широта: " << lat << " " << m_points.size();

            QModelIndex start_index = createIndex(0, 0);
            QModelIndex end_index = createIndex((m_points.count() - 1), 0);
            emit dataChanged(start_index, end_index);

            break;
        }

    }

    if(!isChange)
    {
        beginInsertRows(QModelIndex(), rowCount(), rowCount());
        m_points << *pointer;
        endInsertRows();
        qDebug() << "Новый указатель. Трек: " << track_id << " Широта: " << lat << " " << m_points.size();
    }
}

int CurrentPhotoPointer::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent);
    return m_points.count();
}

QVariant CurrentPhotoPointer::data(const QModelIndex & index, int role) const {

    qDebug() << index.row() << " " << index.column() << " " << role;

    if (index.row() < 0 || index.row() >= m_points.count())
        return QVariant();

    const CurrentPoint &point = m_points[index.row()];
    if (role == IdRole)
        return point.track_id();
    else if (role == LatRole)
        return point.lat();
    else if (role == LonRole)
        return point.lon();
    else if (role == ColorRole)
        return point.color();
    return QVariant();
}

QVariant CurrentPhotoPointer::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role != Qt::DisplayRole)
            return QVariant();

        if (orientation == Qt::Horizontal)
            return QString("Column %1").arg(section);
        else
            return QString("Row %1").arg(section);
}

Qt::ItemFlags CurrentPhotoPointer::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::ItemIsEnabled;

    return QAbstractItemModel::flags(index) | Qt::ItemIsEditable;
}

bool CurrentPhotoPointer::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (index.isValid() && role == Qt::EditRole) {

        //stringList.replace(index.row(), value.toString());
        emit dataChanged(index, index);
        return true;
    }

    return false;
}

QHash<int, QByteArray> CurrentPhotoPointer::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[IdRole] = "track_id";
    roles[LatRole] = "lat";
    roles[LonRole] = "lon";
    roles[ColorRole] = "color_track";
    return roles;
}

