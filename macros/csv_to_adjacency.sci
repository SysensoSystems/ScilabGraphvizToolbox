// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

function [varargout] = csv_to_adjacency(filePath)
    //   Helps to read adjacency matrix from the given .csv file 
    //
    //   Syntax
    //   csv_to_adjacency(filePath
    //   adjacencyData = csv_to_adjacency(filePath)
    //   [adjacencyData,nodeLabels] = csv_to_adjacency(filePath)
    //   
    //   Parameters
    //   filePath : Name or Path of the dot file.
    //   adjacencyData : Adjacency Matrix
    //   nodeLabels : column/node labels of the adjacency matrix
    //   
    //   Description
    //   csv_to_adjacency useful to read a csv file and returns adjacent matrix.
    //
    //   Examples
    //   // This example shows how an adjacency matrix from the given CSV file converted as a Scilab matrix.
    //   // csvFilePath - path of sample csv file.
    //   // returns 'adj' - adjacency matrix.
    //  csvFilePath = uigetfile(["*.csv";],'','Select the CSV file which has adjacency data')
    //  adj = csv_to_adjacency(csvFilePath)
    //

    data = csvRead(filePath,',',[],"string");
    if isempty(data(1))
        value = data(1,:);
        value(1) = [];
        nodeLabels = value;
        index = [];
        for ii = 1:size(nodeLabels,2)
            if isempty(nodeLabels(ii))
                index = [index ii];
            end
        end
        nodeLabels(index) = index;
        data(1,:) =[];
        data(:,1) =[];
        try
            adjacencyData = strtod(data);
        catch
            error("Value error:Adjacency data should be of type constants");
        end
        if ~isequal(size(nodeLabels,2),size(adjacencyData,1))
            error("Value error: Number of node labels should match size of matrix data")
        end
        if ~issquare(adjacencyData)
            error("Value error: Adjacency data should be a square matrix")
        end
    else
        nodeLabels = [];
        try
            adjacencyData = strtod(data);
        catch
            error("Value error:Adjacency data should be of type constants");
        end
        if ~issquare(adjacencyData)
            error("Value error:Adjacency data should be a square matrix")
        end
    end

    // Return argument
    varargout(1) = adjacencyData;
    if nargout == 2
        varargout(1) = adjacencyData;
        varargout(2) = nodeLabels;
    end

endfunction
