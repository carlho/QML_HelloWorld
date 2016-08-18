import QtQuick 2.0
import "pointSketch.js" as PointSketch

Rectangle {
    id: bottom


    color: "darkgrey"

    Text {
        id: statusText;
        text: "Ready"
        font.family: "Helvetica"
        font.italic: true
        font.pointSize: 12
        color: "black"
    }

    function updateStatusText()
    {
        statusText.text = PointSketch.StatusEnum.properties[PointSketch.status].statusText;
    }


}


