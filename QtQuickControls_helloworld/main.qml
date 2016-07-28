import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.0 // Not sure what this is, recommended as debug for jQuery on SE. /CH
import "qrc:/jquery/jquery-ui-1.11.4.custom/external/jquery/jquery.js" as JQ
import Hello 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    menuBar: MenuBar {

        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: console.log("Open action triggered");
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    Rectangle {
        id:drawArea
        width: parent.width*3/4
        height: parent.height
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

            /*
            hoverEnabled: true

            onEntered:
            {
                parent.color = "darkgrey"
                helloText.text = "Entered"
            }
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
            onClicked:
            {
                var node = Qt.createComponent("Node.qml");
                if (node.status == Component.Ready) {

                        var dynamicObject = node.createObject(drawArea);
                        if (dynamicObject == null) {
                            console.log("error creating block");
                            console.log(component.errorString());
                            return false;
                        }
                        dynamicObject.xPos = mouseX
                        dynamicObject.yPos = mouseY
                }
            }
        }

        Text {
            id: helloText
            text: "Hello world!"
            y: 30
            anchors.horizontalCenter: drawArea.horizontalCenter
            font.pointSize: 24; font.bold: true

            MouseArea { id: mouseArea; anchors.fill: parent }

            states: State {
                  name: "down"; when: mouseArea.pressed == true
                  PropertyChanges { target: helloText; y: 160; rotation: 180; color: "red" }
            }

            transitions: Transition {
                  from: ""; to: "down"; reversible: true
                  ParallelAnimation {
                       NumberAnimation { properties: "y,rotation"; duration: 500; easing.type: Easing.InOutQuad }
                       ColorAnimation { duration: 500 }
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


    Rectangle {
        id: right
        x: parent.width*3/4
        width: parent.width/4
        height: parent.height

        
        color: "darkgrey"

        Rectangle{
            id: smallRect
            width: parent.width/5
            height: width
            x: parent.width/2 - width/2
            y: 10
            color: "red"

            NumberAnimation on y{
                from: 10; to: 200
                duration: 1000
            }

            MouseArea{
                anchors.fill: parent

                onClicked: {
                    parent.y = 10
                }
            }
        }


        MouseArea{
            anchors.fill: parent
        }
    }
}
