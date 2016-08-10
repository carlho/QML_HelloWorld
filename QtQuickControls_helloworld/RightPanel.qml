import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: right


    color: "darkgrey"


    TabView {
        id: frame
        //height: 100//parent.height - 50
        anchors.fill: parent
        anchors.margins: 0//4
        Tab { title: "Draw" }
        Tab { title: "Analyze" }
        Tab { title: "Plot" }

        //"#909090"

        style: TabViewStyle {
            frameOverlap: 1
            tab: Rectangle {
                color: styleData.selected ? "#909090" :"darkgrey"
                border.color:  "#909090"
                implicitWidth: Math.max(text.width + 4, 80)
                implicitHeight: 40// height of tab rectangle
                radius: 0
                Text {
                    id: text
                    anchors.centerIn: parent
                    text: styleData.title
                    color: styleData.selected ? "white" : "black"
                }
            }
            frame: Rectangle { color: "#909090" }
        }
    }



    /* CARLS ANIMATED RECTANGLE
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
    */


    /*
    MouseArea{
        anchors.fill: parent
    }
    */
}
