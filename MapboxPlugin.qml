import QtQuick 2.0
import QtLocation  5.3


Plugin {
    id: mapboxPlugin
    name: "mapbox"
    PluginParameter { name: "mapbox.access_token"; value: "pk.eyJ1IjoicHJvbWlzdHJpbyIsImEiOiJjaW1wNmIzaHQwMDJ5d2FtNGNhb28zZTRsIn0.nYE56atkirjFdB5oEkpYVA" }
    PluginParameter {name: "mapbox.map_id"; value: "promistrio.1i2blkkj" }
    PluginParameter {name: "mapbox.mapping.additional_map_ids"; value: "promistrio.cdlgxz71, promistrio.4p8nigwh" }
}


//promistrio.4p8nigwh - фурмановка
// promistrio.cdlgxz71 - Тихорецк
//promistrio.1i2blkkj - Основная карта
