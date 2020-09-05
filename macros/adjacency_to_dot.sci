// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

function varargout = adjacency_to_dot(data,varargin)    
    //  Helps to generate DOT file for the given adjacency matrix.
    //
    //   Syntax
    //   adjacency_to_dot(data) 
    //   adjacency_to_dot(data,outputFilePath)  
    //   adjacency_to_dot(data,outputFilePath,nodeLabels)   
    //   outputFilePath = adjacency_to_dot(data) 
    //   
    //   Parameters
    //   data : It should be a adjacency matrix
    //   outputFilePath : It should be a existing file path or a newfile 
    //   nodeLabels : Name of the nodes[length should same as adjacency matrix]
    //                Note: nodeLabels can be row or column vector.
    //   
    //   Description
    //   adjacency_to_dot useful to generate a DOT file from the given adjacency matrix.
    //
    //   Examples
    //   // The below adjacency matrix will be used to generate DOT file. This file will be added in the current directory.
    //
    //   adj = [0.   1.   1.   0.   0.   0.   0.   0.   0.   0.   0.
    //        0.   0.   0.   1.   1.   1.   0.   0.   0.   0.   0.
    //        0.   0.   0.   0.   0.   0.   0.   1.   0.   0.   0.
    //        0.   0.   0.   0.   0.   0.   0.   0.   0.   0.   0.
    //        0.   0.   0.   0.   0.   0.   1.   0.   0.   0.   0.
    //        0.   0.   0.   0.   0.   0.   0.   0.   0.   0.   0.
    //        0.   0.   0.   0.   0.   0.   0.   0.   0.   0.   1.
    //        0.   0.   0.   0.   0.   0.   0.   0.   1.   1.   0.
    //        0.   0.   0.   0.   0.   0.   0.   0.   0.   0.   0.
    //        0.   0.   0.   0.   0.   0.   0.   0.   0.   0.   0.
    //        0.   0.   0.   0.   0.   0.   0.   0.   0.   0.   0.]
    //   adjacency_to_dot(adj,'adjacencyMatrix.dot')
    //
    //   Examples
    //   // The below adjacency matrix and the column lables will be used to generate DOT file in the respective path given. 
    //
    //   adj = [0.   1.   1.   0.   0.   0.   0.   0.   0.   0.   0.
    //        0.   0.   0.   1.   1.   1.   0.   0.   0.   0.   0.
    //        0.   0.   0.   0.   0.   0.   0.   1.   0.   0.   0.
    //        0.   0.   0.   0.   0.   0.   0.   0.   0.   0.   0.
    //        0.   0.   0.   0.   0.   0.   1.   0.   0.   0.   0.
    //        0.   0.   0.   0.   0.   0.   0.   0.   0.   0.   0.
    //        0.   0.   0.   0.   0.   0.   0.   0.   0.   0.   1.
    //        0.   0.   0.   0.   0.   0.   0.   0.   1.   1.   0.
    //        0.   0.   0.   0.   0.   0.   0.   0.   0.   0.   0.
    //        0.   0.   0.   0.   0.   0.   0.   0.   0.   0.   0.
    //        0.   0.   0.   0.   0.   0.   0.   0.   0.   0.   0.]
    //   labels =["a","b","c","d","e","f","g","h","i","j","k"]
    //   dotFilePath = uiputfile(["*.dot";],'','Select the .dot file path')
    //   outputFilePath = adjacency_to_dot(adj,dotFilePath,labels)
    //

    // Input validations
    if nargin < 1 || nargin > 3
        error("Wrong number of input arguments. Please check the function syntax.");
    end    
    if nargin == 1
        outputFilePath = "";
        node_labels = [];
    elseif nargin == 2
        outputFilePath = varargin(1);
        node_labels = [];
    elseif nargin == 3
        outputFilePath = varargin(1);
        node_labels = varargin(2);
    end
    if ~issquare(data)
        error("Adjacency matrix should be a square matrix.");
    end
    if ~isequal(typeof(outputFilePath),'string')
        error("outputFile Path should be of type string.");
    end
    if isempty(outputFilePath)
        outputFilePath = uiputfile(["*.dot";"*.gv"],pwd(),"Choose a file to save");
        if isempty(outputFilePath)
            return;
        end
        extension = fileext(outputFilePath);
        if isempty(extension)
            outputFilePath = [outputFilePath + ".dot"];
        end
    end
    if ~isempty(node_labels)
        if iscell(node_labels)
            try
                node_labels = cell2mat(node_labels);
            catch 
                error("NodeLabels - String type expected for all cell contents");
            end
        end
        matrixSize = size(data,1);
        row = size(node_labels,1);
        col = size(node_labels,2);
        if ~(isequal(row,matrixSize) || isequal(col,matrixSize))
            error("Node labels (row or column) size should be equal to size of Adjacency Matrix");
        end
        if ~(isequal(row,1) || isequal(col,1))
            error("NodeLabels - Row vector or Column vector expected");
        else
            node_labels = matrix(node_labels,1,max(row,col));
        end
        if ~isequal(typeof(node_labels),'string')
            error("NodeLabels - Row vector or Column vector expected");
        end
    end 
    if ~isequal(typeof(data),"constant")
        error('Ajacency Matrix should be of type constant')
    end

    // Process the adjacency matrix
    width = 10;
    height = 10;
    directed = 1; 
    fid = mopen(outputFilePath, 'w');
    mfprintf(fid, 'digraph G {\n');
    edgetxt = '->'; 
    labeltxt = '';
    mfprintf(fid, 'center = 1;\n');
    mfprintf(fid, 'size='"%d,%d'";\n', width, height);
    nodes = size(data,1);
    // Process NODEs 
    for node = 1:nodes               
        if isempty(node_labels)
            mfprintf(fid, '%d;\n', node);
        else
            mfprintf(fid, '%s;\n', node_labels(node));
        end
    end
    if isempty(node_labels)
        edgeformat = strcat(['%d ',edgetxt,' %d ',labeltxt,';\n']);
    else
        edgeformat = strcat(['%s ',edgetxt,' %s ',labeltxt,';\n']);
    end
    // Process EDGEs
    for node1 = 1:nodes              
        arcs = find(data(node1,:)); 
        for node2 = arcs
            if isempty(node_labels)
                mfprintf(fid, edgeformat, node1, node2);
            else
                mfprintf(fid, edgeformat, node_labels(node1), node_labels(node2));
            end
        end
    end
    mfprintf(fid, '}'); 
    mclose(fid);

    // Set output argument.
    if nargout == 1
        varargout(1) = outputFilePath;
    end

endfunction
