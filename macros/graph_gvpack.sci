// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

function varargout = graph_gvpack(varargin)
    //   Helps to merge and pack two or more .dot/.gv files to a single .dot/.gv file.
    //
    //   Syntax
    //   outputGraph = graph_gvpack('inputFiles',{'inputFile1','inputFile2,...'})
    //   outputGraph = graph_gvpack('inputFiles',{'inputFile1','inputFile2,...'},'graphName',"GraphName")
    //   graph_gvpack('inputFiles',{'inputFile1','inputFile2,...'},'outputFile','output.dot')
    //   graph_gvpack('inputFiles',{'inputFile1','inputFile2,...'},'outputFile','output.dot','graphName',"GraphName")
    //   
    //   Parameters
    //   It uses "<Parameter>, <Value>" key value pair arguments. The parameter pair can be used in any order.
    //   inputFiles : Name or Path of the dot/gv files.
    //   graphName : graphName will be used as the name of the generated graph.
    //   outputGraph: It can be a existing file path or a newfile .
    //   
    //   Description
    //   graph_gvpack useful to merge and pack 2 or more .dot/.gv file to single .dot/.gv file.
    //
    //   Examples
    //   // This example shows how a single graph is generated from 2 or more 
    //   // .dot/.gv files. 
    //   firstFilePath = uigetfile(["*.dot";"*.gv"],'','Select the DOT/GV file');
    //   secondFilePath = uigetfile(["*.dot";"*.gv"],'','Select the DOT/GV file');
    //   outputGraph = graph_gvpack('inputFiles',{firstFilePath,secondFilePath});
    //   // outputGraph - Contains generated graph.
    //   
    //   Examples
    //   // This example shows how a single graph is generated with given graphName
    //   // from 2 or more .dot/.gv files. 
    //   firstFilePath = uigetfile(["*.dot";"*.gv"],'','Select the DOT/GV file');
    //   secondFilePath = uigetfile(["*.dot";"*.gv"],'','Select the DOT/GV file');
    //   outputGraph = graph_gvpack('inputFiles',{firstFilePath,secondFilePath},'nodeName','Sample');
    //   
    //   Examples
    //   // This example shows how a single graph is generated from 2 or more 
    //   // .dot/.gv files.
    //   firstFilePath = uigetfile(["*.dot";"*.gv"],'','Select the DOT/GV file');
    //   secondFilePath = uigetfile(["*.dot";"*.gv"],'','Select the DOT/GV file'); 
    //   graph_gvpack('inputFiles',{firstFilePath,secondFilePath},'outputFile','output.dot')
    //

    // Input Validation
    totalFiles = [];
    [inputFiles,outputFilePath,graphName] = processInputs(varargin(:));
    if isempty(inputFiles)
        error('Insufficient Input Files: Provide atleast 2 files to proceed.')
    end
    for ii = 1:length(inputFiles)
        filePath = inputFiles{ii};
        [filevalue,err] = fileinfo(filePath)
        extension = fileext(filePath);
        if ~isequal(err,0) || ~(strcmp(extension,'.gv','i') || strcmp(extension,'.dot','i'))
            error('Invalid File: Please check the Input File');
        else
            if isempty(totalFiles)
                totalFiles = strcat([totalFiles,filePath]);
            else
                totalFiles = strcat([totalFiles,' ',filePath]);
            end
        end
    end

    // Check whether to print the output to Scilab command window
    if ~isempty(graphName)
        graphName = strcat(['-s ',graphName]);
    end
    if isempty(outputFilePath)
        baseCommand  = strcat(['dot ',totalFiles,'|','gvpack -array_i ',graphName]);
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
        baseCommand  = strcat(['dot ',totalFiles,'|','gvpack -array_i -o ',outputFilePath,' ',graphName]);
        [out,errorValue,errorStatus] = unix_g(baseCommand);
        if errorValue
            error('Graphviz failure. Please check the input File.');
        end
    end
endfunction
/******************************************************************************/
function [inputFiles,outputFilePath,graphName] = processInputs(varargin)
    // Process the inputs and perform error checking    

    labels = {"inputFiles","outputFile","graphName"};
    inputFiles = '';
    outputFilePath = '';
    graphName = '';
    for i = 1:2:length(varargin)
        arg = varargin(i);
        if ~strcmp(arg,labels{1},'i')
            inputFiles = varargin(i+1);
            if ~(iscellstr(inputFiles) && (length(inputFiles) >= 2))
                error('Please check the Input Files path.or Insufficient Input Files.')
            end
        elseif ~strcmp(arg,labels{2},'i')
            outputFilePath = varargin(i+1);
            if strcmp(typeof(outputFilePath),'string')
                error('Please check the Output File path.')
            end
        elseif ~strcmp(arg,labels{3},'i')
            graphName = varargin(i+1);
        end
    end

endfunction
