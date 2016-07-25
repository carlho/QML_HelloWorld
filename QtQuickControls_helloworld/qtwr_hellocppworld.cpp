#include "qtwr_hellocppworld.h"

QtWr_HelloCppWorld::QtWr_HelloCppWorld()
{
    _hw = HelloCPPWorld();
}

QString QtWr_HelloCppWorld:: name() const
{
    return QString::fromStdString(_hw.name());
}


void QtWr_HelloCppWorld:: setName(const QString &name)
{
    _hw.setName(name.toStdString());
}
