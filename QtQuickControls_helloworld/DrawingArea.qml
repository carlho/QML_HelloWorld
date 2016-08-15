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


    QtWr_HelloCppWorld
    {
        id: cppObject
        name: "Hello C++ World"
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

        /*
        onExited:
        {
            parent.color = "lightgrey"
            helloText.text = "Hello world!"
        }
        */

        onPressAndHold:{ helloText.text = cppObject.name }

        onReleased: { helloText.text = "Hello world!" }


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

    Text {
        id: helloText
        text: "Hello world!"
        y: 30
        anchors.horizontalCenter: drawArea.horizontalCenter
        font.pointSize: 36; font.bold: true

        MouseArea { id: mouseArea; anchors.fill: parent }

        states: State
        {
              name: "down";
              when: mouseArea.pressed == true
              PropertyChanges
              {
                  target: helloText;
                  y: 300;
                  //font.pointSize: 50;
                  //font.capitalization: Font.SmallCaps
                  rotation: 180;
                  color: "red"
              }
        }

        transitions: Transition
        {
              from: "";
              to: "down";
              reversible: true
              ParallelAnimation
              {
                   NumberAnimation
                   {
                       properties: "y,rotation";
                       duration: 800;
                       easing.type: Easing.OutElastic
                   }

                   ColorAnimation { duration: 800 }
              }
        }
    }



    Grid {
        id: colorPicker
        x: 4; anchors.bottom: drawArea.bottom; anchors.bottomMargin: 4
        rows: 2; columns: 3; spacing: 3

        Cell { cellColor: "red"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "green"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "blue"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "yellow"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "steelblue"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "black"; onClicked: helloText.color = cellColor }
    }



}
