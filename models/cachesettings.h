#ifndef CACHESETTINGS_H
#define CACHESETTINGS_H

#include <QObject>
#include <QSettings>
#include <QDebug>

class CacheSettings : public QObject
{
    Q_OBJECT
public:
    explicit CacheSettings(QSettings &settings, QObject *parent = nullptr);
    Q_INVOKABLE QString cachePath();
    Q_INVOKABLE void onOrtho();
    Q_INVOKABLE void offOrtho();

signals:

public slots:

private:
    QSettings * p_settings;
};

#endif // CACHESETTINGS_H
