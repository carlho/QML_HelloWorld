import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "pointSketch.js" as PointSketch

Rectangle {
    id: right


    color: "darkgrey"


    TabView {
        id: frame
        //height: 100//parent.height - 50
        anchors.fill: parent
        anchors.margins: 0//4
        Tab {
            title: "Draw"

            Item{
                StandardPsButton{
                    id: btnPoint
                    buttonText: "Point"
                    btnWidth: parent.width / 2
                    xPos: 0
                    yPos: 30
                    onClicked: PointSketch.createPointBtnClicked()
                }

                StandardPsButton{
                    id: btnLine
                    buttonText: "Line"
                    xPos: parent.width / 2
                    yPos: 30
                    btnWidth: parent.width / 2
                    onClicked: PointSketch.createLineBtnClicked()
                }
                StandardPsButton{
                    id: btnPolyline
                    buttonText: "PolyLine"
                    btnWidth: parent.width / 2
                    xPos: 0
                    yPos: 30 + btnLine.btnHeight
                    onClicked: PointSketch.createPolyLineBtnClicked()
                }
                StandardPsButton{
                    id: btnAnchor
                    buttonText: "Anchor"
                    btnWidth: parent.width / 2
                    xPos: parent.width / 2
                    yPos: 30 + btnLine.btnHeight
                    onClicked: PointSketch.createAnchorBtnClicked()
                }

                StandardPsButton{
                    id: btnAbort
                    buttonText: "Abort Command"
                    btnWidth: parent.width / 2
                    btnHeight: 50
                    xPos: 60//parent.width / 2 + btnAbort.width / 2
                    yPos: 350//30 + btnLine.btnHeight
                    onClicked: PointSketch.createAnchorBtnClicked()
                }





            }



        }
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
