import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.3
import QtQuick.Window 2.0 // Not sure what this is, recommended as debug for jQuery on SE. /CH
import "pointSketch.js" as PointSketch
import Hello 1.0
import CustomGeometry 1.0

Rectangle {

    id: drawArea
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

        onPressAndHold:{
            helloText.text = cppObject.name
        }

        onReleased: {helloText.text = "Hello world!"}


        // Add node
        onClicked: {
            // If wanting to finish creating an an element
            if (PointSketch.creatingElement)
            {
                PointSketch.finishElementCreation(mouseX, mouseY)
            }

            PointSketch.addNode(mouseX, mouseY)
        }


    }

    function doStuffTest(x, y){
        PointSketch.drawElement(x, y)
    }

    Rectangle{
        id: bounceRec
        x: parent.x
        y: parent.y
        width: 80
        height: 80

        MouseArea { id: mouseArea2; anchors.fill: parent }

        states: State
        {
              name: "up2";
              when: mouseArea2.pressed == true
              PropertyChanges
              {
                  target: bounceRec;
                  y: bounceRecItem.y-10;
                  x: bounceRecItem.x+50;
                  //rotation: 180;
                  color: "blue"
              }
        }

        transitions: Transition
        {
              from: "";
              to: "up2";
              //reversible: true
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
