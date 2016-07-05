import QtQuick 2.3
import QtQuick.Controls 1.2

ApplicationWindow {
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
        id:page
        width: parent.width*3/4
        height: parent.height
        color: "lightgrey"

        MouseArea {
            id: mouseAreaRect
            anchors.fill: parent
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

            // Add node
            onClicked:
            {
                parent.color = "blue"
            }
        }

        Text {
            id: helloText
            text: "Hello world!"
            y: 30
            anchors.horizontalCenter: page.horizontalCenter
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
            x: 4; anchors.bottom: page.bottom; anchors.bottomMargin: 4
            rows: 2; columns: 3; spacing: 3

            Cell { cellColor: "red"; onClicked: helloText.color = cellColor }
            Cell { cellColor: "green"; onClicked: helloText.color = cellColor }
            Cell { cellColor: "blue"; onClicked: helloText.color = cellColor }
            Cell { cellColor: "yellow"; onClicked: helloText.color = cellColor }
            Cell { cellColor: "steelblue"; onClicked: helloText.color = cellColor }
            Cell { cellColor: "black"; onClicked: helloText.color = cellColor }
        }


    }
}
