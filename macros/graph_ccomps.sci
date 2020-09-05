// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

function varargout = graph_ccomps(filePath,varargin)
    //   Helps to find the connected companents of the given .dot/.gv file 
    //
    //   Syntax
    //   outputGraph = graph_ccomps(filePath)
    //   outputGraph = graph_ccomps(filePath,"nodeName","nodeName")
    //   graph_ccomps(filePath,"outputFile",outputFile)
    //   graph_ccomps(filePath,"outputFile",outputFile,"nodeName","nodeName")
    //   
    //   Parameters
    //   It uses "Parameter, Value" key value pair arguments. The parameter pair can be used in any order.
    //   filePath : Name or Path of the dot/gv file.
    //   nodeName : Generate only the components contaning the given node name.
    //   outputFile : It should be a existing file path or a newfile .
    //   If more than one graph is produced, then the remaining files will be
    //   suffixed with the index numbers.(eg.outputFile.dot,outputFile_1.dot,etc..)
    //   
    //   Description
    //   graph_ccomps useful to find the connected companents of the given .dot/.gv file 
    //
    //   Examples
    //   // This example shows how to return the generated graph.
    //   dotFilePath = uigetfile(["*.dot";"*.gv"],'','Select the DOT/GV file');
    //   outputGraph = graph_ccomps(dotFilePath)
    //   // outputGraph - Contains generated graph.
    //
    //   Examples
    //   // This example shows how to save the generated graph in seperate .dot/.gv file.
    //   dotFilePath = uigetfile(["*.dot";"*.gv"],'','Select the DOT/GV file');
    //   graph_ccomps(dotFilePath,'outputFile','output.dot')
    //

    // Input Validation
    [filevalue,err] = fileinfo(filePath)
    extension = fileext(filePath);
    if ~isequal(err,0) || ~(strcmp(extension,'.gv','i') || strcmp(extension,'.dot','i'))
        error('Invalid File: Please check the Input File');
    end
    [outputFilePath,nodeName] = processInputs(varargin(:));

    // Check whether to print the output to Scilab command window
    if isempty(outputFilePath)
        if isempty(nodeName)
            baseCommand  = strcat(['ccomps -x',nodeName,' ',filePath,'|ccomps -x']);
        else
            nodeName = strcat(['X',nodeName]);
            baseCommand  = strcat(['ccomps -x',nodeName,' ',filePath]);
        end
        [out,errorValue,errorStatus] = unix_g(baseCommand);
        if errorValue && ~isempty(errorStatus)
            error(errorStatus);
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
        if ~isempty(nodeName)
            nodeName = strcat(['X',nodeName]);
        end
        baseCommand  = strcat(['ccomps -x',nodeName,' ','-o ',outputFilePath,' ',filePath]);
        [out,errorValue,errorStatus] = unix_g(baseCommand);
        if errorValue && ~isempty(errorStatus)
            error(errorStatus);
        end
    end

endfunction
/******************************************************************************/
function [outputFilePath,nodeName] = processInputs(varargin)
    // Process the inputs and perform error checking    

    labels = {"outputFile","nodeName"};
    outputFilePath = '';
    nodeName = '';
    for i = 1:2:length(varargin)
        arg = varargin(i);
        if ~strcmp(arg,labels{1},'i')
            outputFilePath = varargin(i+1);
            if strcmp(typeof(outputFilePath),'string','i')
                error('Please check the Output File path.')
            end
        elseif ~strcmp(arg,labels{2},'i')
            nodeName = varargin(i+1);
        end
    end

endfunction
