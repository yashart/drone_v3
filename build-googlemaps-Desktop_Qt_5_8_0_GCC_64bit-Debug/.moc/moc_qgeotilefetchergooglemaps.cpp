/****************************************************************************
** Meta object code from reading C++ file 'qgeotilefetchergooglemaps.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.8.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../googlemaps-master/qgeotilefetchergooglemaps.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qgeotilefetchergooglemaps.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.8.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_QGeoTileFetcherGooglemaps_t {
    QByteArrayData data[7];
    char stringdata0[120];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_QGeoTileFetcherGooglemaps_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_QGeoTileFetcherGooglemaps_t qt_meta_stringdata_QGeoTileFetcherGooglemaps = {
    {
QT_MOC_LITERAL(0, 0, 25), // "QGeoTileFetcherGooglemaps"
QT_MOC_LITERAL(1, 26, 18), // "_networkReplyError"
QT_MOC_LITERAL(2, 45, 0), // ""
QT_MOC_LITERAL(3, 46, 27), // "QNetworkReply::NetworkError"
QT_MOC_LITERAL(4, 74, 5), // "error"
QT_MOC_LITERAL(5, 80, 15), // "_replyDestroyed"
QT_MOC_LITERAL(6, 96, 23) // "_googleVersionCompleted"

    },
    "QGeoTileFetcherGooglemaps\0_networkReplyError\0"
    "\0QNetworkReply::NetworkError\0error\0"
    "_replyDestroyed\0_googleVersionCompleted"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QGeoTileFetcherGooglemaps[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    1,   29,    2, 0x08 /* Private */,
       5,    0,   32,    2, 0x08 /* Private */,
       6,    0,   33,    2, 0x08 /* Private */,

 // slots: parameters
    QMetaType::Void, 0x80000000 | 3,    4,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void QGeoTileFetcherGooglemaps::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QGeoTileFetcherGooglemaps *_t = static_cast<QGeoTileFetcherGooglemaps *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->_networkReplyError((*reinterpret_cast< QNetworkReply::NetworkError(*)>(_a[1]))); break;
        case 1: _t->_replyDestroyed(); break;
        case 2: _t->_googleVersionCompleted(); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 0:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QNetworkReply::NetworkError >(); break;
            }
            break;
        }
    }
}

const QMetaObject QGeoTileFetcherGooglemaps::staticMetaObject = {
    { &QGeoTileFetcher::staticMetaObject, qt_meta_stringdata_QGeoTileFetcherGooglemaps.data,
      qt_meta_data_QGeoTileFetcherGooglemaps,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *QGeoTileFetcherGooglemaps::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QGeoTileFetcherGooglemaps::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_QGeoTileFetcherGooglemaps.stringdata0))
        return static_cast<void*>(const_cast< QGeoTileFetcherGooglemaps*>(this));
    return QGeoTileFetcher::qt_metacast(_clname);
}

int QGeoTileFetcherGooglemaps::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QGeoTileFetcher::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
