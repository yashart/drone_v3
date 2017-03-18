import QtQuick 2.4
import QtQuick.Controls 1.4

MenuBar {
    Menu {
        title: qsTr("Треки")
        MenuItem {text: "Создать маршрут"}
        MenuItem {text: "Открыть маршрут"}
        MenuItem {text: "Закрыть маршрут"}
        MenuItem {text: "Сохранить маршрут"}
        MenuItem {text: "Загрузить маршрут в БПЛА"}
        MenuItem {text: "Выполнить полетное задание"}
        MenuItem {text: "Выход"}
    }
    Menu {
        title: qsTr("Операции")
        MenuItem {text: "Карты"}
        MenuItem {text: "Источник карты"}
        MenuItem {text: "Масштаб"}
        MenuItem {text: "Измерение расстояния"}
        MenuItem {text: "Измерение углов"}
        MenuItem {text: "Прейти в заданную точку"}
        MenuItem {text: "Сохранить выделенную область в кэш"}
        MenuItem {text: "Видео"; onTriggered: {videoPage.visible=true}}
    }
    Menu {
        title: qsTr("Вид")
        MenuItem {text: "Меню быстрого запуска"}
        MenuItem {text: "Масштаб"}
        MenuItem {text: "Источники"}
        MenuItem {text: "Статусная строка"}
        MenuItem {text: "Масштабная линейка"}
        MenuItem {text: "Инверсия цвета"}
    }
    Menu {
        title: qsTr("Маршрут")
        MenuItem {text: "Создать метку"}
        MenuItem {text: "Изменить метку"}
        MenuItem {text: "Удалить метку"}
        MenuItem {text: "Загрузить из GPS"}
    }
    Menu {
        title: qsTr("Анализ")
        MenuItem {text: "LOG-файл"}
    }
    Menu {
        title: qsTr("Параметры")
        MenuItem {text: "Настройка"}
    }
    Menu {
        title: qsTr("Окна")
        MenuItem {
                text: "Треки/карты"
                onTriggered: {
                    leftTabMenu.visible = true
                }
            }
    }
    Menu {
        title: qsTr("Помощь")
    }
}
