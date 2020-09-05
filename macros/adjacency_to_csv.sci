// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

function [varargout] = adjacency_to_csv(data,varargin)
    //   Helps to write the adjacency matrix to a .csv file 
    //
    //   Syntax
    //   adjacency_to_csv(data)
    //   adjacency_to_csv(data,outputFilePath)  
    //   adjacency_to_csv(data,outputFilePath,nodeLabels)   
    //   outputFilePath = adjacency_to_csv(data)
    //   
    //   Parameters
    //   data : Adjacency matrix
    //   outputFilePath : CSV file path to write the data
    //   nodeLabels : Name of the nodes[length should same as adjacency matrix]
    //                Note: nodeLabels can be row or column vector.
    //   
    //   Description
    //   adjacency_to_csv useful to generate a CSV file from the given adjacency matrix.
    //
    //   Examples
    //   // This example shows how an adjacency matrix can be written to a CSV file.
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
    //        0.   0.   0.   0.   0.   0.   0.   0.   0.   0.   0.];
    //   csvFilePath = uiputfile(["*.csv";],'','Select the .csv file path');
    //   adjacency_to_csv(adj,csvFilePath)
    //
    //   Examples
    //   // This example shows how an adjacency matrix with lables can be written to a CSV file.
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
    //        0.   0.   0.   0.   0.   0.   0.   0.   0.   0.   0.];
    //   labels =["a","b","c","d","e","f","g","h","i","j","k"];
    //   csvFilePath = uiputfile(["*.csv";],'','Select the .csv file path');
    //   outputFilePath = adjacency_to_csv(adj,csvFilePath,labels)
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
        outputFilePath = uiputfile(["*.csv"],pwd(),"Choose a file to save");
        if isempty(outputFilePath)
            return;
        end
        extension = fileext(outputFilePath);
        if isempty(extension)
            outputFilePath = [outputFilePath + ".csv"];
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
    else
        rowSize = size(data,1);
        node_labels = [1:rowSize];
    end 
    if ~isequal(typeof(data),"constant")
        error('Ajacency Matrix should be of type constant')
    end
    csvData = [];
    csvData(1,1) = "";
    for ii = 1:max(size(node_labels))
        csvData(1,ii+1) = string(node_labels(ii));
        csvData(ii+1,1) = string(node_labels(ii));
    end

    for ii = 1:size(data,1)
        rowData = data(ii,:);
        for jj = 1:length(rowData)
            csvData(ii+1,jj+1) = string(rowData(jj));
        end
    end

    write_csv(csvData,outputFilePath,",");

    // Set output argument.
    if nargout == 1
        varargout(1) = outputFilePath;
    end

endfunction
