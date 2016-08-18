import QtQuick 2.0
import "pointSketch.js" as PointSketch

Rectangle {
    id: bottom

    property string statusText: PointSketch.StatusEnum.properties[1].statusText

    color: "darkgrey"

    Text {
        text: statusText
        font.family: "Helvetica"
        font.italic: true
        font.pointSize: 12
        color: "black"
    }
}
