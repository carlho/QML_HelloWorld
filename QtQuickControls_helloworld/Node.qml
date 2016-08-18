import QtQuick 2.0
import "pointSketch.js" as PointSketch

Item {
    id: node

    property int xPos: 0
    property int yPos: 0

    width: 15; height: 15

    Component.onCompleted:
    {
        node.sendCoordinates.connect(send)
    }

    function send(x, y)
    {
        if (PointSketch.creatingElement)
        {
            PointSketch.drawElement(mouseX, mouseY)
        }
    }

    signal sendCoordinates(var x, var y)

    Rectangle {
        id: circle
        x: xPos-height/2
        y: yPos-width/2
        width: parent.width<parent.height?parent.width:parent.height
        height: width
        color: "darkgrey"
        border.color: "black"
        border.width: 1
        radius: width*0.5

        function createElementFromNode()
        {
            drawArea.nodeClickedDuringElementCreation(node.xPos, node.yPos);
        }

        MouseArea
        {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true

            onClicked:
            {
                circle.createElementFromNode();
            }



            onPositionChanged:
            {
                //parent.color = "black"

                sendCoordinates(mouseX, mouseY)
            }

            onExited:
            {
                parent.color = "darkgrey"
            }

            onDoubleClicked: node.destroy()
        }

        //////////// STATES ////////////

        states: State {
                    name: "hovered"; when: mouseArea.onEntered;
                    PropertyChanges { target: circle; color: "black" }
                }

        Transition {
                from: "*"; to: "hovered"
                ColorAnimation {
                    from: circle.color
                    to: "black"
                    duration: 200 }
                reversible: true
            }
    }
}
