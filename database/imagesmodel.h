#ifndef IMAGESMODEL_H
#define IMAGESMODEL_H

#include <QObject>
#include <QSqlQueryModel>

class ImagesModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    QStringList list_id;
    /* Перечисляем все роли, которые будут использоваться в TableView
     * Как видите, они должны лежать в памяти выше параметра Qt::UserRole
     * Связано с тем, что информация ниже этого адреса не для кастомизаций
     * */
    enum Roles {
        IdRole = Qt::UserRole + 1,      // id
        LatRole,
        LonRole,
        AltRole,
        DirRole,
        URLRole,
        CommentRole,
        TypeRole,
        ARole,
        BRole,
        CRole,
        DRole,
        AzimuthRole
    };

    // объявляем конструктор класса
    explicit ImagesModel(QObject *parent = 0);

    // Переопределяем метод, который будет возвращать данные
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    Q_INVOKABLE QVariant get(int row, QString role);

protected:
    /* хешированная таблица ролей для колонок.
     * Метод используется в дебрях базового класса QAbstractItemModel,
     * от которого наследован класс QSqlQueryModel
     * */
    QHash<int, QByteArray> roleNames() const;
    int id_track;

signals:

public slots:
    void updateModel();
    void changeId(int new_id);
    int getId(int row);
};

#endif // IMAGESMODEL_H
