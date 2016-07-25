#include "hellocppworld.h"

HelloCPPWorld::HelloCPPWorld()
{

}

std::string HelloCPPWorld::name() const
{
    return _name;
}


void HelloCPPWorld::setName(const std::string &name)
{
    _name = name;
}
