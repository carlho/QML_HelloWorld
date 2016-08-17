import QtQuick 2.0
import CustomGeometry 1.0


CustomLine
{
    id: cppLine

    function setP1(x, y)
    {
        p1: Qt.point(x, y)
    }

    function setP2(x, y)
    {
        p2: Qt.point(x, y)
    }
}
