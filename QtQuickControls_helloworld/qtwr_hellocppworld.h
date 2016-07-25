#ifndef QTWR_HELLOCPPWORLD_H
#define QTWR_HELLOCPPWORLD_H

#include "hellocppworld.h"
#include <QObject>

class QtWr_HelloCppWorld : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName)

public:
    QtWr_HelloCppWorld();

    QString name() const;
    void setName(const QString &name);

private:
    HelloCPPWorld _hw;
};

#endif // QTWR_HELLOCPPWORLD_H
