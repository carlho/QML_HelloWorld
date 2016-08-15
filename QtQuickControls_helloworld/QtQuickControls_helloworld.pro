TEMPLATE = app

QT += qml quick widgets

CONFIG += c++11

SOURCES += main.cpp \
    hellocppworld.cpp \
    qtwr_hellocppworld.cpp \
    qelement2d.cpp \
    qcustomline.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES +=

HEADERS += \
    hellocppworld.h \
    qtwr_hellocppworld.h \
    qelement2d.h \
    qcustomline.h
