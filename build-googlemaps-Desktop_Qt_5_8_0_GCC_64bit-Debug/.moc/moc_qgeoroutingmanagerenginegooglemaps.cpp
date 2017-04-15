/****************************************************************************
** Meta object code from reading C++ file 'qgeoroutingmanagerenginegooglemaps.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.8.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../googlemaps-master/qgeoroutingmanagerenginegooglemaps.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qgeoroutingmanagerenginegooglemaps.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.8.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_QGeoRoutingManagerEngineGooglemaps_t {
    QByteArrayData data[7];
    char stringdata0[105];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_QGeoRoutingManagerEngineGooglemaps_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_QGeoRoutingManagerEngineGooglemaps_t qt_meta_stringdata_QGeoRoutingManagerEngineGooglemaps = {
    {
QT_MOC_LITERAL(0, 0, 34), // "QGeoRoutingManagerEngineGoogl..."
QT_MOC_LITERAL(1, 35, 13), // "replyFinished"
QT_MOC_LITERAL(2, 49, 0), // ""
QT_MOC_LITERAL(3, 50, 10), // "replyError"
QT_MOC_LITERAL(4, 61, 21), // "QGeoRouteReply::Error"
QT_MOC_LITERAL(5, 83, 9), // "errorCode"
QT_MOC_LITERAL(6, 93, 11) // "errorString"

    },
    "QGeoRoutingManagerEngineGooglemaps\0"
    "replyFinished\0\0replyError\0"
    "QGeoRouteReply::Error\0errorCode\0"
    "errorString"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QGeoRoutingManagerEngineGooglemaps[] = {

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
       3,    2,   25,    2, 0x08 /* Private */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 4, QMetaType::QString,    5,    6,

       0        // eod
};

void QGeoRoutingManagerEngineGooglemaps::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QGeoRoutingManagerEngineGooglemaps *_t = static_cast<QGeoRoutingManagerEngineGooglemaps *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->replyFinished(); break;
        case 1: _t->replyError((*reinterpret_cast< QGeoRouteReply::Error(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        default: ;
        }
    }
}

const QMetaObject QGeoRoutingManagerEngineGooglemaps::staticMetaObject = {
    { &QGeoRoutingManagerEngine::staticMetaObject, qt_meta_stringdata_QGeoRoutingManagerEngineGooglemaps.data,
      qt_meta_data_QGeoRoutingManagerEngineGooglemaps,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *QGeoRoutingManagerEngineGooglemaps::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QGeoRoutingManagerEngineGooglemaps::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_QGeoRoutingManagerEngineGooglemaps.stringdata0))
        return static_cast<void*>(const_cast< QGeoRoutingManagerEngineGooglemaps*>(this));
    return QGeoRoutingManagerEngine::qt_metacast(_clname);
}

int QGeoRoutingManagerEngineGooglemaps::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QGeoRoutingManagerEngine::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 2)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 2)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 2;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
