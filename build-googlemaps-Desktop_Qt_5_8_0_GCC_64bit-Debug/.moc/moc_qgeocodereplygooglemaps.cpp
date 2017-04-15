/****************************************************************************
** Meta object code from reading C++ file 'qgeocodereplygooglemaps.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.8.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../googlemaps-master/qgeocodereplygooglemaps.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qgeocodereplygooglemaps.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.8.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_QGeoCodeReplyGooglemaps_t {
    QByteArrayData data[6];
    char stringdata0[98];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_QGeoCodeReplyGooglemaps_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_QGeoCodeReplyGooglemaps_t qt_meta_stringdata_QGeoCodeReplyGooglemaps = {
    {
QT_MOC_LITERAL(0, 0, 23), // "QGeoCodeReplyGooglemaps"
QT_MOC_LITERAL(1, 24, 20), // "networkReplyFinished"
QT_MOC_LITERAL(2, 45, 0), // ""
QT_MOC_LITERAL(3, 46, 17), // "networkReplyError"
QT_MOC_LITERAL(4, 64, 27), // "QNetworkReply::NetworkError"
QT_MOC_LITERAL(5, 92, 5) // "error"

    },
    "QGeoCodeReplyGooglemaps\0networkReplyFinished\0"
    "\0networkReplyError\0QNetworkReply::NetworkError\0"
    "error"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QGeoCodeReplyGooglemaps[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   24,    2, 0x08 /* Private */,
       3,    1,   25,    2, 0x08 /* Private */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 4,    5,

       0        // eod
};

void QGeoCodeReplyGooglemaps::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QGeoCodeReplyGooglemaps *_t = static_cast<QGeoCodeReplyGooglemaps *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->networkReplyFinished(); break;
        case 1: _t->networkReplyError((*reinterpret_cast< QNetworkReply::NetworkError(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 1:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QNetworkReply::NetworkError >(); break;
            }
            break;
        }
    }
}

const QMetaObject QGeoCodeReplyGooglemaps::staticMetaObject = {
    { &QGeoCodeReply::staticMetaObject, qt_meta_stringdata_QGeoCodeReplyGooglemaps.data,
      qt_meta_data_QGeoCodeReplyGooglemaps,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *QGeoCodeReplyGooglemaps::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QGeoCodeReplyGooglemaps::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_QGeoCodeReplyGooglemaps.stringdata0))
        return static_cast<void*>(const_cast< QGeoCodeReplyGooglemaps*>(this));
    return QGeoCodeReply::qt_metacast(_clname);
}

int QGeoCodeReplyGooglemaps::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QGeoCodeReply::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 2)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 2)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
