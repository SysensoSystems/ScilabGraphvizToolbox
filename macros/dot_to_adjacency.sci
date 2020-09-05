// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

function [varargout] = dot_to_adjacency(filePath,varargin)
    //  Helps to generate adjacency matrix for the given DOT file 
    //
    //   Syntax
    //   dot_to_adjacency(filePath)
    //   dot_to_adjacency(filePath,rankDir)
    //   adj = dot_to_adjacency(filePath,rankDir)
    //   [adj,labels] = dot_to_adjacency(filePath,'rankDir)
    //   
    //   Parameters
    //   filePath : Name or Path of the dot file.
    //   rankDir : Order in which dot file should be parsed(optional).
    //             'TB' stands for "Top to Bottom"
    //             'BT' -  Bottom to Top
    //             'LR' = Left to Right
    //   adj : Adjacency Matrix
    //   labels : column/node labels of the adjacency matrix
    //   
    //   Description
    //   dot_to_adjacency useful to convert a DOT file to an adjacent matrix.
    //
    //   Examples
    //   // This example shows how the adjacency matrix is generated for the given .dot file. 
    //   // Also, it show different input/output options in calling dot_to_adjacency function.
    //   dotFilePath = uigetfile(["*.dot";],'','Select the DOT file');
    //   adj = dot_to_adjacency(dotFilePath)
    //   [adj,labels] = dot_to_adjacency(dotFilePath,'TB')
    // 

    // Input validations
    if nargin < 1 || nargin > 2
        error("Wrong number of input arguments. Please check the function syntax.");
    end 
    rankDir = 'TB';
    if nargin == 2 
        rankDir = varargin(1);
    end

    // Call the Graphviz using sheell commands.
    doscommand = strcat(['dot -Tplain ',filePath]);
    [plainTextCode,errorValue] = unix_g(doscommand);
    if errorValue
        error('GraphViz failure. Please check the inputs.'); 
    end
    // Process the output and generate the adjacency matrix.
    nodeLabels = orderNodeLabels(rankDir,plainTextCode);
    rows = size(nodeLabels,2);
    adj = zeros(rows,rows);
    for index = 1:size(plainTextCode,1)
        text = plainTextCode(index);
        matchedString = strstr(text,'edge');
        if ~isempty(matchedString)
            edgeData = strsplit(matchedString,' ');
            from = edgeData(2);
            to = edgeData(3);
            for ii = 1:size(nodeLabels,2)
                if ~strcmp(from,nodeLabels(ii))
                    for jj = 1:size(nodeLabels,2)
                        if ~strcmp(to,nodeLabels(jj))
                            adj(ii,jj) = 1;                            
                        end
                    end
                end
            end
        end
    end   
    varargout(1) = adj;
    if nargout == 2
        varargout(1) = adj;
        varargout(2) = nodeLabels;
    end

endfunction
/******************************************************************************/
function nodeLabels = orderNodeLabels(rankDir,plainTextCode)
    // Order the nodes as per rand direction.

    if ~strcmp(rankDir,'TB','i')
        index = 4;
        order = 'd';
    elseif ~strcmp(rankDir,'BT','i')
        index = 4;
        order = 'i';
    elseif ~strcmp(rankDir,'LR','i')
        index = 3;
        order = 'i';
    end

    nodeLabels = [];
    nodePosition = [];
    for ii = 1:size(plainTextCode,1)
        text = plainTextCode(ii);
        matchedString = strstr(text,'node');
        if ~isempty(matchedString)
            nodeData = strsplit(matchedString,' ');
            nodeLabels = [nodeLabels nodeData(2)];
            nodePosition = [nodePosition strtod(nodeData(index))];
        end
    end
    [sortedNodePosition,indices] = gsort(nodePosition,'g',order);
    nodeLabels = nodeLabels(indices);

endfunction
