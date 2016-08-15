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
        Tab {
            title: "Draw"
            Item {
                id: button
                width: 30
                height: 30
                property alias buttonText: innerText.text;
                property color color: "white"
                property color hoverColor: "#aaaaaa"
                property color pressColor: "slategray"
                property int fontSize: 10
                property int borderWidth: 1
                property int borderRadius: 2
                scale: state === "Pressed" ? 0.96 : 1.0
                onEnabledChanged: state = ""
                signal clicked

                //define a scale animation
                Behavior on scale {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                //Rectangle to draw the button
                Rectangle {
                    id: rectangleButton
                    anchors.fill: parent
                    radius: borderRadius
                    color: button.enabled ? button.color : "grey"
                    border.width: borderWidth
                    border.color: "black"

                    Text {
                        id: innerText
                        font.pointSize: fontSize
                        anchors.centerIn: parent
                    }
                }

                //change the color of the button in differen button states
                states: [
                    State {
                        name: "Hovering"
                        PropertyChanges {
                            target: rectangleButton
                            color: hoverColor
                        }
                    },
                    State {
                        name: "Pressed"
                        PropertyChanges {
                            target: rectangleButton
                            color: pressColor
                        }
                    }
                ]

                //define transmission for the states
                transitions: [
                    Transition {
                        from: ""; to: "Hovering"
                        ColorAnimation { duration: 200 }
                    },
                    Transition {
                        from: "*"; to: "Pressed"
                        ColorAnimation { duration: 10 }
                    }
                ]

                //Mouse area to react on click events
                MouseArea {
                    hoverEnabled: true
                    anchors.fill: button
                    onEntered: { button.state='Hovering'}
                    onExited: { button.state=''}
                    onClicked: { button.clicked();}
                    onPressed: { button.state="Pressed" }
                    onReleased: {
                        if (containsMouse)
                          button.state="Hovering";
                        else
                          button.state="";
                    }
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
