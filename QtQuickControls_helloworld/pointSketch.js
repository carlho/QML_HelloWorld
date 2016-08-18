/* This scrips file handles pointsketch logic */

// Node variables
var creatingNode = false;
var nodes = [];     // List of nodes on canvas
var node            // Actual node

// Element variables
var creatingElement = false;
var continuousElementCreation = false;
var line;
var elem;
var elements = [];


var StatusEnum = {
    Ready: 1,
    CreateNode: 2,
    CreateElement1: 3,
    CreateElement2: 4,
    DeleteNode: 5,
    DeleteElement: 6,
    properties: {
    1:{statusText: "Ready"},
    2:{statusText: "Create a node"},
    3:{statusText: "Create an element"},
    4:{statusText: "Create an element 2"},
    5:{statusText: "Delete a node"},
    6:{statusText: "Delete an element"}
    }
};

//Sets the status variable to create node by default
var status = StatusEnum.Ready;


function abortCommand()
{
    if(status === StatusEnum.CreateElement2)
        abortCreatingElement();

    status = StatusEnum.Ready;
    // Add abort actions for other events here
}


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





function drawElement(x, y)
{
    // If drawing element first time create element and the first point of it
    if (status === StatusEnum.CreateElement1)
    {
        line = 0;                   // Reset line

        addElement2d(x, y, x, y);   // Add element at coordinates. x2 and y2 will be set later

        //creatingElement = true;     // Flag for element creation in progress
        status = StatusEnum.CreateElement2;
    }

    // Update secont point of the element
    else if (status === StatusEnum.CreateElement2)
    {
        line.elemP2(x,y);
    }
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

function finishElementCreation(x, y)
{
    line.elemP2(x,y);
    elements.push(line);
    if (continuousElementCreation)
    {
        status = StatusEnum.CreateElement1;
        drawElement(x,y);
        //node.createElementFromNode();
    }
    else
        status = StatusEnum.Ready;
}

function abortCreatingElement()
{
    line.destroy();
    status = StatusEnum.Ready;
    continuousElementCreation = false;
}
