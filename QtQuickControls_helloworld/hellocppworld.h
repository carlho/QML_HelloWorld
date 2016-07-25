#ifndef HELLOCPPWORLD_H
#define HELLOCPPWORLD_H

#include <QString>
#include <string>

class HelloCPPWorld
{
    std::string _name;

public:
    HelloCPPWorld();

    std::string name() const;
    void setName(const std::string &name);

};

#endif // HELLOCPPWORLD_H
