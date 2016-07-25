#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>
#include <QGuiApplication>
#include "qtwr_hellocppworld.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<QtWr_HelloCppWorld>("Hello", 1, 0, "QtWr_HelloCppWorld");

/*
    QQuickView view;
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.setSource(QUrl("qrc:///main.qml"));
    view.show();
*/

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));


    return app.exec();
}
