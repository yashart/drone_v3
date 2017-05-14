#include "database.h"
#include "imagesmodel.h"

ImagesModel::ImagesModel(QObject *parent) :
    QSqlQueryModel(parent)
{
    this->updateModel();
}

/* Метод для получения данных из модели.
 * Вообще этот метод создан для QML. Именно он его скрытно
 * использует
*/
QVariant ImagesModel::data(const QModelIndex & index, int role) const
{
    // Определяем номер колонки, по номеру роли
    int columnId = role - Qt::UserRole - 1;
    // Создаём индекс с помощью новоиспечённого ID колонки
    QModelIndex modelIndex = this->index(index.row(), columnId);

    /* И с помощью уже метода data() базового класса
     * вытаскиваем данные для таблицы из модели
     * */
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QVariant ImagesModel::get(int row,QString role)
{
    QHash<QString, int> roles;;  // Есть более верное решение
    roles["track_id"] = IdRole;
    roles["lat"] = LatRole;
    roles["lon"] = LonRole;
    roles["alt"] = AltRole;
    roles["dir"] = DirRole;
    roles["url"] = URLRole;
    roles["comment"] = CommentRole;
    roles["type"] = TypeRole;

    int columnId = roles[role] - Qt::UserRole - 1;
    // Создаём индекс с помощью новоиспечённого ID колонки
    QModelIndex modelIndex = this->index(row, columnId);

    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}


//Метод для получения имен ролей через хешированную таблицу.
QHash<int, QByteArray> ImagesModel::roleNames() const {
    /* То есть сохраняем в хеш-таблицу названия ролей
     * по их номеру
     * */
    QHash<int, QByteArray> roles;
    roles[IdRole] = "track_id";
    roles[LatRole] = "lat";
    roles[LonRole] = "lon";
    roles[AltRole] = "alt";
    roles[DirRole] = "dir";
    roles[URLRole] = "url";
    roles[CommentRole] = "comment";
    roles[TypeRole] = "type";
    return roles;
}

// Метод обновления таблицы в модели представления данных
void ImagesModel::updateModel()
{
    // Обновление производится SQL-запросом к базе данных
    QString str_query("SELECT ");
    str_query.append("Points.track_id, ");
    str_query.append("Points.lat, ");
    str_query.append("Points.lon, ");
    str_query.append("Points.alt, ");
    str_query.append("Tracks.dir, ");
    str_query.append("Points.url, ");
    str_query.append("Points.comment, ");
    str_query.append("Points.type ");
    str_query.append("FROM Points ");
    str_query.append("LEFT OUTER JOIN Tracks ON Tracks.id = Points.track_id ");
    str_query.append( QString( "WHERE Points.track_id IN (%1) " ).arg( id_track ) );
    str_query.append("ORDER BY Points.track_id ASC;");
    this->setQuery(str_query);

    while(this->canFetchMore()){ // загрузка всех данных в кэш
        this->fetchMore();
    }
}

void ImagesModel::changeId(int new_id)
{
    id_track = new_id;
}

//Получение id из строки в модели представления данных
int ImagesModel::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}
