import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.3
import QtQuick.Window 2.0 // Not sure what this is, recommended as debug for jQuery on SE. /CH
//import "qrc:/jquery/jquery-ui-1.11.4.custom/external/jquery/jquery.js" as JQ
import "pointSketch.js" as PointSketch
import Hello 1.0
import CustomGeometry 1.0

ApplicationWindow {
    id: mainWindow
    objectName: "mainWindow"
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    flags: Qt.FramelessWindowHint //suppresses the standard windows frame

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

            Menu {
                title: "Edit"
                MenuItem { text: "Cut" }
                MenuItem { text: "Copy" }
                MenuItem { text: "Paste" }
            }

            //tweaking the style
            style: MenuBarStyle {
                padding {
                    left: 8
                    right: 8
                    top: 3
                    bottom: 3
                }

                background: Rectangle {
                    id: rect
                    //border.color: menuBorderColor
                    color: "#282828"//"#000000"//menuBackgroundColor


                }

                itemDelegate: Rectangle {            // the menus
                    implicitWidth: lab.contentWidth * 1.4           // adjust width the way you prefer it
                    implicitHeight: lab.contentHeight               // adjust height the way you prefer it
                    color: "#282828" //#000000"//styleData.selected || styleData.open ? "red" : "transparent"
                    Label {
                        id: lab
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: styleData.selected  || styleData.open ? "white" : "grey"
                        font.wordSpacing: 10
                        text: styleData.text
                    }
                }

            }
        }

    property var bottomPanelHieght : 40

    // This is the main drawing area
    DrawingArea
    {
        width: parent.width*3/4
        height: parent.height-bottomPanelHieght
    }

    // The right panel
    RightPanel
    {
        x: parent.width*3/4
        y: 30
        width: parent.width/4
        height: parent.height-bottomPanelHieght
    }

    //The bootom panel
    BottomPanel
    {
        x:0
        y: parent.height-bottomPanelHieght
        width: parent.width
        height: bottomPanelHieght
    }

    Item {
        id: rootItem
        anchors.fill: parent
        clip: true

        state: "wizard"
        states: [
            State {
                name: "wizard"
                //PropertyChanges { target: leftPanel; visible: false }
                //PropertyChanges { target: rightPanel; visible: false }
                //PropertyChanges { target: middlePanel; visible: false }
                PropertyChanges { target: titleBar; basicButtonVisible: false }
                //PropertyChanges { target: wizard; visible: true }
                PropertyChanges { target: mainWindow; width: 930; }
                PropertyChanges { target: mainWindow; height: 595; }
                PropertyChanges { target: resizeArea; visible: false }
                PropertyChanges { target: titleBar; maximizeButtonVisible: false }
                PropertyChanges { target: frameArea; blocked: true }
                PropertyChanges { target: titleBar; y: 0 }
                PropertyChanges { target: titleBar; title: "PointSketch 2.0" }
            }, State {
                name: "normal"
                /*
                PropertyChanges { target: leftPanel; visible: true }
                PropertyChanges { target: rightPanel; visible: true }
                PropertyChanges { target: middlePanel; visible: true }
                PropertyChanges { target: titleBar; basicButtonVisible: true }
                PropertyChanges { target: wizard; visible: false }
                PropertyChanges { target: mainWindow; width: rightPanelExpanded ? 1269 : 1269 - 300; }
                PropertyChanges { target: mainWindow; height: 800; }
                PropertyChanges { target: resizeArea; visible: true }
                PropertyChanges { target: titleBar; maximizeButtonVisible: true }
                PropertyChanges { target: frameArea; blocked: false }
                PropertyChanges { target: titleBar; y: -titleBar.height }
                PropertyChanges { target: titleBar; title: "Monero  -  Donations" }
                */
            }
        ]



        MouseArea {
            id: frameArea
            property bool blocked: false
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 30
            z: 1
            hoverEnabled: true
            onEntered: if(!blocked) titleBar.y = 0
            onExited: if(!blocked) titleBar.y = -titleBar.height
            propagateComposedEvents: true
            onPressed: mouse.accepted = false
            onReleased: mouse.accepted = false
            onMouseXChanged: titleBar.mouseX = mouseX
            onContainsMouseChanged: titleBar.containsMouse = containsMouse
        }

        SequentialAnimation {
            id: goToBasicAnimation
            PropertyAction {
                target: mainWindow
                properties: "visibility"
                //value: Window.Windowed
            }
            PropertyAction {
                target: titleBar
                properties: "maximizeButtonVisible"
                value: false
            }
            PropertyAction {
                target: frameArea
                properties: "blocked"
                value: true
            }
            PropertyAction {
                target: resizeArea
                properties: "visible"
                value: false
            }
            NumberAnimation {
                target: mainWindow
                properties: "height"
                to: 30
                easing.type: Easing.InCubic
                duration: 200
            }
            NumberAnimation {
                target: mainWindow
                properties: "width"
                to: 470
                easing.type: Easing.InCubic
                duration: 200
            }
            PropertyAction {
                //targets: [leftPanel, middlePanel, rightPanel]
                properties: "visible"
                value: false
            }
            PropertyAction {
                //target: basicPanel
                properties: "visible"
                value: true
            }
            NumberAnimation {
                target: mainWindow
                properties: "height"
                //to: basicPanel.height
                easing.type: Easing.InCubic
                duration: 200
            }

            onStopped: {
                middlePanel.visible = false
                rightPanel.visible = false
                leftPanel.visible = false
            }
        }

        SequentialAnimation {
            id: goToProAnimation
            NumberAnimation {
                target: mainWindow
                properties: "height"
                to: 30
                easing.type: Easing.InCubic
                duration: 200
            }
            PropertyAction {
                //target: basicPanel
                properties: "visible"
                value: false
            }
            PropertyAction {
                //targets: [leftPanel, middlePanel, rightPanel, resizeArea]
                properties: "visible"
                value: true
            }
            NumberAnimation {
                target: mainWindow
                properties: "width"
                //to: rightPanelExpanded ? 1269 : 1269 - 300
                easing.type: Easing.InCubic
                duration: 200
            }
            NumberAnimation {
                target: mainWindow
                properties: "height"
                to: 800
                easing.type: Easing.InCubic
                duration: 200
            }
            PropertyAction {
                target: frameArea
                properties: "blocked"
                value: false
            }
            PropertyAction {
                target: titleBar
                properties: "maximizeButtonVisible"
                value: true
            }
        }


        //property int maxWidth: leftPanel.width + 655 + rightPanel.width
        property int maxHeight: 700
        MouseArea {
            id: resizeArea
            hoverEnabled: true
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 30
            width: 30

            Rectangle {
                anchors.fill: parent
                color: parent.containsMouse || parent.pressed ? "#111111" : "#282828"//"transparent"
            }

            Image {
                anchors.centerIn: parent
                source: parent.containsMouse || parent.pressed ? "images/resizeHovered.png" :
                                                                 "images/resize.png"
            }

            property int previousX: 0
            property int previousY: 0
            onPressed: {
                previousX = mouseX
                previousY = mouseY
            }

            onPositionChanged: {
                if(!pressed) return
                var dx = previousX - mouseX
                var dy = previousY - mouseY

                if(mainWindow.width - dx > parent.maxWidth)
                    mainWindow.width -= dx
                else mainWindow.width = parent.maxWidth

                if(mainWindow.height - dy > parent.maxHeight)
                    mainWindow.height -= dy
                else mainWindow.height = parent.maxHeight
            }
        }

        TitleBar {
            id: titleBar
            anchors.left: parent.left
            anchors.right: parent.right
            onGoToBasicVersion: {
                if(yes) goToBasicAnimation.start()
                else goToProAnimation.start()
            }

            MouseArea {
                property var previousPosition
                anchors.fill: parent
                propagateComposedEvents: true
                onPressed: previousPosition = Qt.point(mouseX, mouseY)
                onPositionChanged: {
                    if (pressedButtons == Qt.LeftButton) {
                        var dx = mouseX - previousPosition.x
                        var dy = mouseY - previousPosition.y
                        mainWindow.x += dx
                        mainWindow.y += dy
                    }
                }
            }
        }
    }
}
