// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

function graphMetrics = graph_gc(filePath)
    //   Helps to gather the graph metrics for the given .dot/.gv file
    //
    //   Syntax
    //   graphMetrics = graph_gc(filePath)
    //   
    //   Parameters
    //   filePath : Name or Path of the dot/gv file.
    //   
    //   Description
    //   graph_gc useful to find the graph metrics for the given .dot/.gv file
    //
    //   Examples
    //   // This example shows how the graph metrics is generated for the given .dot/.gv file. 
    //   // Also, it show different input/output options in calling graph_ccomps function.
    //   dotFilePath = uigetfile(["*.dot";"*.gv"],'','Select the DOT/GV file');
    //   graphMetrics = graph_gc(dotFilePath)
    //   // graphMetrics - graphMetrics is a structure containing the graph information,
    //   // namely number of nodes, edges, connected components and clusters.
    //   


    // Inpt Validation
    [filevalue,err] = fileinfo(filePath)
    extension = fileext(filePath);
    if ~isequal(err,0) || ~(strcmp(extension,'.gv','i') || strcmp(extension,'.dot','i'))
        error('Invalid File: Please check the Input File');
    end

    baseCommand = strcat(['gc -a',' ',filePath]);
    [output,errorValue] = unix_g(baseCommand);

    if isempty(output) || errorValue
        error('GraphViz failure. Please check the inputs.'); 
    end

    splittedValue = strsplit(output," ");
    splittedValue(splittedValue == "") = [];
    graphMetrics.nodes = strtod(splittedValue(1));
    graphMetrics.edges = strtod(splittedValue(2));
    graphMetrics.ccomps = strtod(splittedValue(3));
    graphMetrics.cluster = strtod(splittedValue(4));
    graphMetrics.graphName = splittedValue(5);

endfunction
