import QtQuick 2.0

Item {
    id: node
    signal activated(real xPos, real yPos)

    property int xPos: 0
    property int yPos: 0

    width: 15; height: 15

    Rectangle {
        id: circle
        x: xPos-height/2
        y: yPos-width/2
        width: parent.width<parent.height?parent.width:parent.height
        height: width
        color: "black"
        border.color: "black"
        border.width: 1
        radius: width*0.5

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                activate(node.xPos, node.yPos)
                //parent.color: "red"
            }

            onEntered: {
                parent.color = "black"
            }

            onExited: {
                parent.color = "darkgrey"
            }

            onDoubleClicked: node.destroy()
        }
    }
}
