
add_library(Qt5::QGeoServiceProviderFactoryGooglemaps MODULE IMPORTED)

_populate_Location_plugin_properties(QGeoServiceProviderFactoryGooglemaps DEBUG "geoservices/libqtgeoservices_googlemaps.so")

list(APPEND Qt5Location_PLUGINS Qt5::QGeoServiceProviderFactoryGooglemaps)
