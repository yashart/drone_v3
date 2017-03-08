import QtQuick 2.0
import QtLocation  5.6


Plugin {
    id: customPlugin
    name: "osm"
    PluginParameter {
       name: "osm.mapping.custom.host"
       value: "file:///home/yashart/Documents/Programming/drone_v3/drone_v3/customMap/"
    }

    //PluginParameter {
    //   name: "osm.mapping.providersrepository.disabled"
    //   value: true
    //}
}
