import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.3
import QtQuick.Window 2.0 // Not sure what this is, recommended as debug for jQuery on SE. /CH
import "pointSketch.js" as PointSketch
import Hello 1.0
import CustomGeometry 1.0

Rectangle {

    id: drawArea

    focus: true
    Keys.onEscapePressed: PointSketch.abortCommand();

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


        hoverEnabled: true

        onEntered:
        {

        }

        onPositionChanged:
        {
            if (PointSketch.creatingElement)
            {
                PointSketch.drawElement(mouseX, mouseY)
            }
        }


        // Add node
        onClicked:
        {
            // If wanting to finish creating an an element
            if (PointSketch.creatingElement)
            {
                PointSketch.finishElementCreation(mouseX, mouseY)
            }

            // Create node regardless of whether an element is being created or not
            PointSketch.addNode(mouseX, mouseY)
        }


    }

    function doStuffTest(x, y)
    {
        if(PointSketch.creatingElement)
        {
            PointSketch.finishElementCreation(x, y)
        }
        else
        {
            PointSketch.drawElement(x, y)
        }
    }
}
