/* This scrips file handles pointsketch logic */

// Node variables
var node            // Actual node
var nodeComponent   // Node component

function addNode(x, y) {
        var nodeComponent = Qt.createComponent("Node.qml");
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
                if (nodeComponent == null) {
                    console.log("error creating block");
                    console.log(component.errorString());
                    return false;
                }
            }
        }
}


function doStuffAtNodeClick(){
    node.color = "green";
}

