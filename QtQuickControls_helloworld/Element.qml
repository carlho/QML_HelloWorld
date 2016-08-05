import QtQuick 2.0
import CustomGeometry 1.0

Item {
    id: element2d

    property int x1: 0
    property int y1: 0
    property int x2: 0
    property int y2: 0

    x: x1
    y: y1
    width: x2-x1
    height: y2-y1

    Element2d
    {
        id: elem
        anchors.fill: parent
    }

    function elemP2(x, y)
    {
        //elem.x2 = x;
        //elem.y2 = y;

        element2d.x2 = x;
        element2d.y2 = y;

        //elem.p2 = Qt.point(1,1);
    }
}
