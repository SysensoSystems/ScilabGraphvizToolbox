// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

function varargout = graph_cluster(filePath,varargin)
    //   Helps to find clusters in a .dot/.gv file and augment the cluster information.
    //
    //   Syntax
    //   outputGraph = graph_cluster(filePath)
    //   outputGraph = graph_cluster(filePath,'cluster',ClusterCount)
    //   graph_cluster(filePath,'outputFile','output.dot')
    //   graph_cluster(filePath,'outputFile','output.dot','cluster',ClusterCount)
    //   
    //   Parameters
    //   It uses "Parameter, Value" key value pair arguments. The parameter pair can be used in any order.
    //   filePath : Name or Path of the dot/gv file.
    //   cluster : Specifies number of cluster to be generated for the graph.
    //   outputFile : It should be a existing file path or a newfile .
    //   
    //   Description
    //   graph_cluster useful to find clusters in a .dot/.gv file and augment the cluster information
    //
    //   Examples
    //   // This example shows how clusters are found for the given .dot/.gv file 
    //   // and generated graph is returned.
    //   dotFilePath = uigetfile(["*.dot";"*.gv"],'','Select the DOT/GV file');
    //   outputGraph = graph_cluster(dotFilePath)
    //   // outputGraph - Contains generated graph.
    //
    //   Examples
    //   // This example shows how clusters are found for the given .dot/.gv file 
    //   // and save the generated graph in seperate file.
    //   dotFilePath = uigetfile(["*.dot";"*.gv"],'','Select the DOT/GV file');
    //   graph_cluster(dotFilePath,'outputFile','output.dot')
    //


    // Inpt Validation
    [filevalue,err] = fileinfo(filePath)
    extension = fileext(filePath);
    if ~isequal(err,0) || ~(strcmp(extension,'.gv','i') || strcmp(extension,'.dot','i'))
        error('Invalid File: Please check the Input File');
    end
    [outputFilePath,clusterCount] = processInputs(varargin(:));

    // Check whether to print the output to Scilab command window
    if ~isempty(clusterCount)
        clusterCount = strcat(['-C ',clusterCount]);
    end
    if isempty(outputFilePath)
        baseCommand  = strcat(['dot ',filePath,'|','gvmap ',clusterCount,'| dot -G_background=""""']);
        [out,errorValue,errorStatus] = unix_g(baseCommand);
        if errorValue
            if isempty(errorStatus)
                error('Graphviz failure. Please check the inputs.'); 
            else
                error(errorStatus);
            end
        else
            if nargout == 0
                disp(out)
            elseif nargout == 1
                varargout(1) = out;
            end 
        end
    else
        extension = fileext(outputFilePath);
        if isempty(extension)
            outputFilePath = [outputFilePath + ".dot"];
        end
        baseCommand  = strcat(['dot ',filePath,'|','gvmap ',clusterCount,'| dot -G_background=""""',' -o ',outputFilePath]);
        [out,errorValue,errorStatus] = unix_g(baseCommand); 
        if errorValue
            error('Graphviz failure. Please check the input File.');
        end
    end
endfunction
/******************************************************************************/
function [outputFilePath,clusterCount] = processInputs(varargin)
    // Process the inputs and perform error checking    

    labels = {"outputFile","cluster"};
    outputFilePath = '';
    clusterCount = '';
    for i = 1:2:length(varargin)
        arg = varargin(i);
        if ~strcmp(arg,labels{1},'i')
            outputFilePath = varargin(i+1);
            if strcmp(typeof(outputFilePath),'string')
                error('Please check the Output File path.')
            end
        elseif ~strcmp(arg,labels{2},'i')
            clusterCount = varargin(i+1);
            if ~(isnum(clusterCount) || isscalar(clusterCount))
                error('Type error: integer expected for cluster value.')
            end
        end
    end

endfunction
