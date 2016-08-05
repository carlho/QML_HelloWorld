/* This scrips file handles pointsketch logic */

// Node variables
var nodes = [];     // List of nodes on canvas
var node            // Actual node

// Element variables
var creatingElement = false;
var line
var elements = [];

function addNode(x, y) {

    var nodeComponent   // Node component

    nodeComponent = Qt.createComponent("Node.qml");
    if (nodeComponent.status == Component.Ready)
        finishNodeCreation(x, y);
    else
        nodeComponent.statusChanged.connect(finishNodeCreation);


    // Connect node activate signal to function
    //node.AtActivated.connect(doStuffAtNodeClick);


    // Finishes node creation
    function finishNodeCreation(x, y){
        if (nodeComponent.status == Component.Ready)
        {
            node = nodeComponent.createObject(drawArea, {"xPos": x, "yPos": y});
            //node.onActivated.connect(doStuffAtNodeClick)
            if (nodeComponent == null) {
                console.log("error creating block");
                console.log(component.errorString());
                return false;
            }
        }
    }

    nodes.push(node);
}


function doStuffAtNodeClick(){
    node.width = 30;
}



function drawElement(x, y){

    // Create first point of element
    if (!creatingElement){
        line = 0                    // Reset line

        addElement2d(x, y, x, y);   // Add element at coordinates. x2 and y2 will be set later

        creatingElement = true;     // Flag for element creation in progress
    }

    // Create second point of element
    else{
        line.elemP2(x,y);
    }
}

function finishElementCreation(x, y){
    line.elemP2(x,y);
    elements.push(line);
    creatingElement = false;
}



function addElement2d(x1, y1, x2, y2) {

    var elemComponent   // Node component

    elemComponent = Qt.createComponent("Element.qml");
    if (elemComponent.status == Component.Ready)
        finishElem2dCreation(x1, y1, x2, y2);
    else
        elemComponent.statusChanged.connect(finishElem2dCreation);


    // Connect node activate signal to function
    //node.AtActivated.connect(doStuffAtNodeClick);


    // Finishes node creation
    function finishElem2dCreation(x1, y1, x2, y2){
        if (elemComponent.status == Component.Ready)
        {
            line = elemComponent.createObject(drawArea, {"x1": x1, "y1": y1, "x2": x2, "y2": y2});
            if (elemComponent == null) {
                console.log("error creating block");
                console.log(component.errorString());
                return false;
            }
        }
    }
}
