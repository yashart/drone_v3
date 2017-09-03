#include "qgeotilefetchergooglemaps.h"
#include "qgeomapreplygooglemaps.h"
#include "qgeotiledmapgooglemaps.h"
#include "qgeotiledmappingmanagerenginegooglemaps.h"
#include <QtLocation/private/qgeotilespec_p.h>


QT_BEGIN_NAMESPACE

namespace
{

    int _getServerNum(int x, int y, int max)
    {
        return (x + 2 * y) % max;
    }

}

QGeoTileFetcherGooglemaps::QGeoTileFetcherGooglemaps(const QVariantMap &parameters,
                                           QGeoTiledMappingManagerEngineGooglemaps *engine,
                                           const QSize &tileSize)
:   QGeoTileFetcher(engine),
  m_networkManager(new QNetworkAccessManager(this)),
  m_engineGooglemaps(engine),
  m_tileSize(tileSize),
  _googleVersionRetrieved(false)
{    
    m_apiKey = parameters.value(QStringLiteral("googlemaps.maps.apikey")).toString();
    m_signature = parameters.value(QStringLiteral("googlemaps.maps.signature")).toString();
    m_client = parameters.value(QStringLiteral("googlemaps.maps.client")).toString();
    m_baseUri = QStringLiteral("http://maps.googleapis.com/maps/api/staticmap");
    m_localpath = QDir::currentPath().append("/").append("cache/orthophoto/%3/%1/%2.png");
    QDir().mkdir("cache");
    if (parameters.contains(QStringLiteral("googlemaps.localpath")))
        _userAgent = parameters.value(QStringLiteral("googlemaps.useragent")).toString().toLatin1();
    else
        _userAgent = "Mozilla/5.0 (X11; Linux i586; rv:31.0) Gecko/20100101 Firefox/31.0";

    QStringList langs = QLocale::system().uiLanguages();
    if (langs.length() > 0) {
        _language = langs[0];
    }

    // Google version strings
    _versionGoogleMap            = "m@338000000";
    _versionGoogleSatellite      = "198";
    _versionGoogleLabels         = "h@336";
    _versionGoogleTerrain        = "t@132,r@338000000";
    _secGoogleWord               = "Galileo";

    _tryCorrectGoogleVersions(m_networkManager);

    netRequest.setRawHeader("Referrer", "https://www.google.com/maps/preview");
    netRequest.setRawHeader("Accept", "*/*");
    netRequest.setRawHeader("User-Agent", _userAgent);

}

QGeoTileFetcherGooglemaps::~QGeoTileFetcherGooglemaps()
{
}

QGeoTiledMapReply *QGeoTileFetcherGooglemaps::getTileImage(const QGeoTileSpec &spec)
{
    QString surl = _getURL(spec.mapId(), spec.x(), spec.y(), spec.zoom());
    qDebug() << surl;
    QUrl url(surl);

    netRequest.setUrl(url);

    QNetworkReply *netReply = m_networkManager->get(netRequest);

    QGeoTiledMapReply *mapReply = new QGeoMapReplyGooglemaps(netReply, spec);

    return mapReply;
}

void QGeoTileFetcherGooglemaps::_getSecGoogleWords(int x, int y, QString &sec1, QString &sec2)
{
    sec1 = ""; // after &x=...
    sec2 = ""; // after &zoom=...
    int seclen = ((x * 3) + y) % 8;
    sec2 = _secGoogleWord.left(seclen);
    if (y >= 10000 && y < 100000) {
        sec1 = "&s=";
    }
}

QString _tileXYToQuadKey(int tileX, int tileY, int levelOfDetail)
{
    QString quadKey;
    for (int i = levelOfDetail; i > 0; i--) {
        char digit = '0';
        int mask   = 1 << (i - 1);
        if ((tileX & mask) != 0) {
            digit++;
        }
        if ((tileY & mask) != 0) {
            digit++;
            digit++;
        }
        quadKey.append(digit);
    }
    return quadKey;
}


QString QGeoTileFetcherGooglemaps::_getURL(int type, int x, int y, int zoom)
{
    QSettings settings( "config.ini", QSettings::IniFormat);
    bool ortho = settings.value("Path/orthophoto").toBool();

    int yy = ( pow(2, zoom) - 1 ) - y;
    QString tile;

    QString path;
    path.append("file:///").append(m_localpath);

    tile = m_localpath.arg(x).arg(yy).arg(zoom);

    QString appDir(QDir::currentPath().append("/"));


    if ( QFile::exists(tile) && ortho == true)
    {
        qDebug() << ">>>>>>>" << path;
        return path.arg(x).arg(yy).arg(zoom);// ty1=(2**tz - 1) - ty
    }
    else
    {
        switch (type) {
            case 0:
            case 1:
            {
                QString appDir(QDir::currentPath().append("/"));
                appDir.append("cache/google/maps/z%3/%4/x%1/%5/y%2.png");

                tile = appDir.arg(x).arg(y).arg(zoom+1).arg(x/1024).arg(y/1024);
                qDebug() << tile;
                /*
                if ( QFile::exists(tile) )
                {
                    QString url("file:///");
                    url.append(tile);
                    url.append("google/maps/z%3/%4/x%1/%5/y%2.png");
                    qDebug<< url;
                    return url.arg(x).arg(y).arg(zoom+1).arg(x/1024).arg(y/1024);
                }*/

                // http://mt1.google.com/vt/lyrs=s
                QString server  = "khm";
                QString request = "kh";
                QString sec1    = ""; // after &x=...
                QString sec2    = ""; // after &zoom=...
                _getSecGoogleWords(x, y, sec1, sec2);
                return QString("http://%1%2.google.com/%3/v=%4&hl=%5&x=%6%7&y=%8&z=%9&s=%10").arg(server).arg(_getServerNum(x, y, 4)).arg(request).arg(_versionGoogleSatellite).arg(_language).arg(x).arg(sec1).arg(y).arg(zoom).arg(sec2);
            }
            break;
            case 2:
            {

                // http://mt1.google.com/vt/lyrs=m
                QString server  = "mt";
                QString request = "vt";
                QString sec1    = ""; // after &x=...
                QString sec2    = ""; // after &zoom=...
                _getSecGoogleWords(x, y, sec1, sec2);
                return QString("http://%1%2.google.com/%3/lyrs=%4&hl=%5&x=%6%7&y=%8&z=%9&s=%10").arg(server).arg(_getServerNum(x, y, 4)).arg(request).arg(_versionGoogleMap).arg(_language).arg(x).arg(sec1).arg(y).arg(zoom).arg(sec2);
            }
            break;
            case 3:
            {
                QString key = _tileXYToQuadKey(x, y, zoom);
                return QString("http://ecn.t%1.tiles.virtualearth.net/tiles/r%2.png?g=%3&mkt=%4").arg(_getServerNum(x, y, 4)).arg(key).arg(0).arg(_language);
            }
            break;
            case 4:
            {
                QString key = _tileXYToQuadKey(x, y, zoom);
                return QString("http://ecn.t%1.tiles.virtualearth.net/tiles/a%2.jpeg?g=%3&mkt=%4").arg(_getServerNum(x, y, 4)).arg(key).arg(0).arg(_language);
            }
            break;
            case 5:
            {
                QString key = _tileXYToQuadKey(x, y, zoom);
                return QString("http://ecn.t%1.tiles.virtualearth.net/tiles/h%2.jpeg?g=%3&mkt=%4").arg(_getServerNum(x, y, 4)).arg(key).arg(0).arg(_language);
            }
            break;
            case 6:
            {
                return QString("file:///D:/build-drone_v3-Desktop_Qt_5_8_0_MinGW_32bit-Release/release/cache/z%3/%4/x%1/%5/y%2.png").arg(x).arg(y).arg(zoom+1).arg(x/1024).arg(y/1024);
            }
            break;
            case 7:
            {
                return path;
            }
            break;
        }
    }
    return "";
}

void QGeoTileFetcherGooglemaps::_networkReplyError(QNetworkReply::NetworkError error)
{
    qWarning() << "Could not connect to google maps. Error:" << error;
    if(_googleReply)
    {
        _googleReply->deleteLater();
        _googleReply = NULL;
    }
}

void QGeoTileFetcherGooglemaps::_replyDestroyed()
{
    _googleReply = NULL;
}

void QGeoTileFetcherGooglemaps::_googleVersionCompleted()
{
    if (!_googleReply || (_googleReply->error() != QNetworkReply::NoError)) {
        qDebug() << "Error collecting Google maps version info";
        return;
    }
    QString html = QString(_googleReply->readAll());

    QRegExp reg("\"*https?://mt\\D?\\d..*/vt\\?lyrs=m@(\\d*)", Qt::CaseInsensitive);
    if (reg.indexIn(html) != -1) {
        QStringList gc = reg.capturedTexts();
        _versionGoogleMap = QString("m@%1").arg(gc[1]);
    }
    reg = QRegExp("\"*https?://khm\\D?\\d.googleapis.com/kh\\?v=(\\d*)", Qt::CaseInsensitive);
    if (reg.indexIn(html) != -1) {
        QStringList gc = reg.capturedTexts();
        _versionGoogleSatellite = gc[1];
    }
    reg = QRegExp("\"*https?://mt\\D?\\d..*/vt\\?lyrs=t@(\\d*),r@(\\d*)", Qt::CaseInsensitive);
    if (reg.indexIn(html) != -1) {
        QStringList gc = reg.capturedTexts();
        _versionGoogleTerrain = QString("t@%1,r@%2").arg(gc[1]).arg(gc[2]);
    }

    _googleReply->deleteLater();
    _googleReply = NULL;
}


void QGeoTileFetcherGooglemaps::_tryCorrectGoogleVersions(QNetworkAccessManager* networkManager)
{
    QMutexLocker locker(&_googleVersionMutex);
    if (_googleVersionRetrieved) {
        return;
    }
    _googleVersionRetrieved = true;
    if(networkManager)
    {
        QNetworkRequest qheader;
        QNetworkProxy proxy = networkManager->proxy();
        QNetworkProxy tProxy;
        tProxy.setType(QNetworkProxy::DefaultProxy);
        networkManager->setProxy(tProxy);
        QSslConfiguration conf = qheader.sslConfiguration();
        conf.setPeerVerifyMode(QSslSocket::VerifyNone);
        qheader.setSslConfiguration(conf);
        QString url = "http://maps.google.com/maps/api/js?v=3.2&sensor=false";
        qheader.setUrl(QUrl(url));
        qheader.setRawHeader("User-Agent", _userAgent);
        _googleReply = networkManager->get(qheader);
        connect(_googleReply, &QNetworkReply::finished, this, &QGeoTileFetcherGooglemaps::_googleVersionCompleted);
        connect(_googleReply, &QNetworkReply::destroyed, this, &QGeoTileFetcherGooglemaps::_replyDestroyed);
        connect(_googleReply, static_cast<void (QNetworkReply::*)(QNetworkReply::NetworkError)>(&QNetworkReply::error),
                this, &QGeoTileFetcherGooglemaps::_networkReplyError);
        networkManager->setProxy(proxy);
    }
}

QT_END_NAMESPACE
