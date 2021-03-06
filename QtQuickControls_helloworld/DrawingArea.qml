import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.3
import QtQuick.Window 2.0 // Not sure what this is, recommended as debug for jQuery on SE. /CH
import "pointSketch.js" as PointSketch
import Hello 1.0
import CustomGeometry 1.0

Rectangle {

    id: drawArea

    //Test to implement zooming capability
    property real zoom: 1.0
    scale: zoom

    focus: true // Sets the focus to this window

    ////////// KEYS /////////
    Keys.onEscapePressed: PointSketch.abortCommand();

    Keys.onPressed: {
            if (event.key === Qt.Key_N)
            {
                PointSketch.creatingNode = true;
                PointSketch.updateStatus(PointSketch.StatusEnum.CreateNode);
                //PointSketch.status = PointSketch.StatusEnum.CreateNode;
            }
            else if (event.key === Qt.Key_L)
            {
                PointSketch.continuousElementCreation = false;
                //PointSketch.status = PointSketch.StatusEnum.CreateElement1
                PointSketch.updateStatus(PointSketch.StatusEnum.CreateElement1);
            }
            else if (event.key === Qt.Key_P)
            {
                PointSketch.continuousElementCreation = true;
                PointSketch.updateStatus(PointSketch.StatusEnum.CreateElement1);
                //PointSketch.status = PointSketch.StatusEnum.CreateElement1
            }
        }

    gradient: Gradient{
        GradientStop{
            position: 0.0;
            color: "darkgrey"
        }
        GradientStop{
            position: 1.0;
            color: "lightgrey"
        }
    }


    // Rätt smutsigt, men orkar inte generera dem dynamiskt just nu...
    Grid {
        id: horizontalLines
        anchors.fill: parent
        columns: 1; spacing: 25

        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
        Line { x: 0; width: drawArea.width; height: 1; }
    }
    Grid {
        id: verticalLines
        anchors.fill: parent
        rows: 1; columns: 30; spacing: 25

        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
        CustomLine { x: 0; height: drawArea.height; width: 1; }
    }




    MouseArea {
        id: mouseAreaRect
        anchors.fill: parent


        //acceptedButtons: Qt.Wheel
        onWheel: {
            if(wheel.modifiers & Qt.ControlModifier){
                drawArea.zoom += wheel.angleDelta.y/1500

                adjustZoom()
                adjustXcoordinate()
                adjustYcoordinate()

            }
            else if (wheel.modifiers & Qt.ShiftModifier){
                drawArea.x +=  wheel.angleDelta.y
                adjustXcoordinate()
            }
            else{
                drawArea.y +=  wheel.angleDelta.y
                adjustYcoordinate()
            }

        // you need to tweak factor above yourself.
        // 800 works for me, but might not be ok for you.
        }
        function adjustXcoordinate()
        {
            if(drawArea.x-drawArea.width/2*(drawArea.zoom-1.0) >0)
                drawArea.x=drawArea.width/2*(drawArea.zoom-1.0)
        }

        function adjustYcoordinate()
        {
            if(drawArea.y-drawArea.height/2*(drawArea.zoom-1.0) >0)
                drawArea.y=drawArea.height/2*(drawArea.zoom-1.0)
        }

        function adjustZoom()
        {
            if(drawArea.zoom< 0.1)
            {
                drawArea.zoom= 0.1
            }
        }
        hoverEnabled: true

        onEntered:
        {

        }

        onPositionChanged:
        {
            if (PointSketch.status === PointSketch.StatusEnum.CreateElement2)
            {
                PointSketch.drawElement(mouseX, mouseY)
            }
        }


        // Add node
        onClicked:
        {
            // If wanting to finish creating an an element
            if (PointSketch.status === PointSketch.StatusEnum.CreateElement2)
            {
                PointSketch.addNode(mouseX, mouseY)

                PointSketch.finishElementCreation(mouseX, mouseY)


            }
            else if(PointSketch.status === PointSketch.StatusEnum.CreateNode)
            {
                PointSketch.addNode(mouseX, mouseY)
            }
        }


    }

    function nodeClickedDuringElementCreation(x, y)
    {
            if(PointSketch.status === PointSketch.StatusEnum.CreateElement2)
            {
                PointSketch.finishElementCreation(x, y)
            }

            PointSketch.drawElement(x, y)
    }
}
