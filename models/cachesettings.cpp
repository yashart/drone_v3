#include "cachesettings.h"

CacheSettings::CacheSettings(QSettings &settings, QObject *parent)
{
    p_settings = &settings;
}

QString CacheSettings::cachePath()
{
    return p_settings->value("Path/path").toString();
}

void CacheSettings::onOrtho()
{
    p_settings->setValue( "Path/orthophoto", true );
    qDebug() << "Ортофото ВКЛ";
}

void CacheSettings::offOrtho()
{
    p_settings->setValue( "Path/orthophoto", false );
    qDebug() << "Ортофото ВЫКЛ";
}
