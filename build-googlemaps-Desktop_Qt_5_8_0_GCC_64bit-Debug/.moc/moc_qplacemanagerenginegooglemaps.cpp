/****************************************************************************
** Meta object code from reading C++ file 'qplacemanagerenginegooglemaps.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.8.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../googlemaps-master/qplacemanagerenginegooglemaps.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qplacemanagerenginegooglemaps.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.8.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_QPlaceManagerEngineGooglemaps_t {
    QByteArrayData data[9];
    char stringdata0[138];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_QPlaceManagerEngineGooglemaps_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_QPlaceManagerEngineGooglemaps_t qt_meta_stringdata_QPlaceManagerEngineGooglemaps = {
    {
QT_MOC_LITERAL(0, 0, 29), // "QPlaceManagerEngineGooglemaps"
QT_MOC_LITERAL(1, 30, 21), // "categoryReplyFinished"
QT_MOC_LITERAL(2, 52, 0), // ""
QT_MOC_LITERAL(3, 53, 18), // "categoryReplyError"
QT_MOC_LITERAL(4, 72, 13), // "replyFinished"
QT_MOC_LITERAL(5, 86, 10), // "replyError"
QT_MOC_LITERAL(6, 97, 18), // "QPlaceReply::Error"
QT_MOC_LITERAL(7, 116, 9), // "errorCode"
QT_MOC_LITERAL(8, 126, 11) // "errorString"

    },
    "QPlaceManagerEngineGooglemaps\0"
    "categoryReplyFinished\0\0categoryReplyError\0"
    "replyFinished\0replyError\0QPlaceReply::Error\0"
    "errorCode\0errorString"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QPlaceManagerEngineGooglemaps[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   34,    2, 0x08 /* Private */,
       3,    0,   35,    2, 0x08 /* Private */,
       4,    0,   36,    2, 0x08 /* Private */,
       5,    2,   37,    2, 0x08 /* Private */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 6, QMetaType::QString,    7,    8,

       0        // eod
};

void QPlaceManagerEngineGooglemaps::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QPlaceManagerEngineGooglemaps *_t = static_cast<QPlaceManagerEngineGooglemaps *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->categoryReplyFinished(); break;
        case 1: _t->categoryReplyError(); break;
        case 2: _t->replyFinished(); break;
        case 3: _t->replyError((*reinterpret_cast< QPlaceReply::Error(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 3:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QPlaceReply::Error >(); break;
            }
            break;
        }
    }
}

const QMetaObject QPlaceManagerEngineGooglemaps::staticMetaObject = {
    { &QPlaceManagerEngine::staticMetaObject, qt_meta_stringdata_QPlaceManagerEngineGooglemaps.data,
      qt_meta_data_QPlaceManagerEngineGooglemaps,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *QPlaceManagerEngineGooglemaps::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QPlaceManagerEngineGooglemaps::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_QPlaceManagerEngineGooglemaps.stringdata0))
        return static_cast<void*>(const_cast< QPlaceManagerEngineGooglemaps*>(this));
    return QPlaceManagerEngine::qt_metacast(_clname);
}

int QPlaceManagerEngineGooglemaps::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QPlaceManagerEngine::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
