import QtQuick 2.0

Item {
        id: button
        width: 100
        height: 100
        anchors.fill: parent
        property alias buttonText: innerText.text;
        property int testVal: 100
        property color color: "white"
        property color hoverColor: "#aaaaaa"
        property color pressColor: "slategray"
        property int fontSize: 10
        property int borderWidth: 0
        property int borderRadius: 2
        scale: state === "Pressed" ? 1.04 : 1.0//0.96 : 1.0
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
            width: frame.width / 3
            height: testVal
            x: 80
            y: 80
            id: rectangleButton
            //anchors.fill: parent
            radius: borderRadius
            color: button.enabled ? "#202020" : "#505050"//button.color : "grey"
            border.width: borderWidth
            border.color: "black"

            Text {
                id: innerText
                font.pointSize: fontSize
                anchors.centerIn: parent
                text: "Bar"
                color: "white"
            }
        }

        //change the color of the button in differen button states
        states: [
            State {
                name: "Hovering"
                PropertyChanges {
                    target: rectangleButton
                    color: "#404040"//hoverColor
                }
            },
            State {
                name: "Pressed"
                PropertyChanges {
                    target: rectangleButton
                    color: "#6B0072"//pressColor
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
            hoverEnabled: button
            anchors.fill: rectangleButton//parent //button
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
