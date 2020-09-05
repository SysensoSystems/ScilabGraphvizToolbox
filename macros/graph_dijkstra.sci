// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

function distanceData = graph_dijkstra(filePath,sourceNode)
    //   Helps to find the distance of each node from the given source node.
    //
    //   Syntax
    //   distanceData = graph_dijkstra(filePath,sourcenode)
    //   
    //   Parameters
    //   filePath : Name or Path of the dot/gv file.
    //   sourceNode : Name of the node.
    //
    //   Description
    //   graph_dijkstra useful to find the distance of each node from the given source node.
    //
    //   Examples
    //   // This example shows how the graph_dijkstra is used to find the distance of each node from the source node.
    //   // Also, it show different input/output options in calling graph_dijkstra function.
    //   dotFilePath = uigetfile(["*.dot";"*.gv"],'','Select the DOT/GV file');
    //   distanceData = graph_dijkstra(dotFilePath,1)
    //   // distanceData - distanceData is a structure containing the maximum distance and node distance informations.
    //   

    // Input Validation
    [filevalue,err] = fileinfo(filePath)
    extension = fileext(filePath);
    if ~isequal(err,0) || ~(strcmp(extension,'.gv','i') || strcmp(extension,'.dot','i'))
        error('Invalid File: Please check the Input File');
    end

    baseCommand  = strcat(['dijkstra ',sourceNode,' ',filePath]);
    [output,errorValue,errorStatus] = unix_g(baseCommand);
    if errorValue
        if isempty(errorStatus)
            error('Graphviz failure. Please check the inputs.'); 
        else
            error(errorStatus);
        end
    else
        output = strcat(output);
        // Split into induvidual values
        output = strsplit(output,';');
        nodeDistance = {};
        maxDistance = {};
        for ii = 1:size(output,1)
            value = output(ii);
            if ~isempty(strindex(value,'maxdist='))
                textWith = 'maxdist=';
                splittedValue = strsplit(value," ");
                distance = getDistance(splittedValue,textWith)
                maxDistance = distance;
            elseif ~isempty(strindex(value,'dist='))
                textWith = 'dist=';
                splittedValue = strsplit(value," ");
                nodeName = splittedValue(1);
                nodeName = stripblanks(nodeName,%t);
                splittedValue = strsplit(splittedValue(2),',');
                distance = getDistance(splittedValue,textWith)
                if isempty(nodeDistance)
                    nodeDistance = {nodeName strtod(distance)}
                else
                    nodeDistance = [nodeDistance;{nodeName} {strtod(distance)}];
                end
            end
        end

        distanceData.nodeDistance = nodeDistance;
        distanceData.maxDistance = strtod(maxDistance);
    end
endfunction
/******************************************************************************/
function distance = getDistance(splittedValue,textWith)

    for jj = 1:size(splittedValue,1)
        value = splittedValue(jj);
        if ~isempty(strindex(value,textWith))
            distString = value;
        end
    end
    distance = strsplit(distString,[',';']';'=']);
    for jj = 1:size(distance,1)
        value = distance(jj);
        if isnum(value)
            distance = value;
            break
        end
    end
endfunction
