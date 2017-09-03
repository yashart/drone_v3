import QtQuick 2.0
import QtLocation  5.6


Plugin {
    id: gmapsPlugin
    name: "googlemaps"
    property variant str: "Hello"
    locales: "en_EN"
    PluginParameter {
        name: "googlemaps.maps.apikey"
        value: "AIzaSyD6YYhz5s4uQ96WuZkbj9-TG5XGTXf4_ZI"
    }
    PluginParameter {
        name: "googlemaps.maps.tilesize"
        value: "256"
    }
    PluginParameter {
        id: localPath
        name: "googlemaps.maps.localpath"
        value: str
    }
}

//AIzaSyD6YYhz5s4uQ96WuZkbj9-TG5XGTXf4_ZI
