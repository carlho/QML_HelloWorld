import QtQuick 2.0

Rectangle {
    id: right


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
