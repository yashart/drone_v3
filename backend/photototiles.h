#ifndef PHOTOTOTILES_H
#define PHOTOTOTILES_H

#include <QObject>
#include <QProcess>
#include <QDir>
#include <QDebug>

class PhotoToTiles : public QObject
{
    Q_OBJECT
    //Q_PROPERTY(QVariantList rulerList READ rulerList NOTIFY rulerListChanged)

public:
    PhotoToTiles(QObject *parent = 0);

    Q_INVOKABLE void translate(QString url, QString range)
    {
        qDebug() << QDir::currentPath() << " " << url << " " << range;
        this->proc.setWorkingDirectory(QDir::currentPath());
        proc.start("python", QStringList() << "gdal2tiles.py" <<"--profile=mercator"<< "-z"<< "17-19"<< url << "orthophoto");
    }
private:
    QProcess proc;

signals:
    void complete();
};

#endif // PHOTOTOTILES_H
