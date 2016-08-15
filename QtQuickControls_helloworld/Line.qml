import QtQuick 2.0
import CustomGeometry 1.0

Item {
    id: line

    property int x1: 0
    property int y1: 0
    property int x2: 0
    property int y2: 0

    x: x1
    y: y1
    width: x2-x1
    height: y2-y1

    CustomLine
    {
        id: cppLine
        anchors.fill: parent
    }

    function setP1(x, y)
    {
        line.x1 = x;
        line.y1 = y;
    }

    function setP2(x, y)
    {
        line.x2 = x;
        line.y2 = y;
    }
}
