// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

function varargout = graph_api(varargin)
    //   graph_api useful to call the Graphviz layout commands(dot/neato/fdp/sfdp/twopi/circo/patchwork/osage) from Scilab. 
    //
    //   Syntax
    //   graph_api("command","neato","data",adj)
    //   graph_api("command","dot","data","dotfile.dot")
    //   graph_api("command","neato","data","dotfile.dot")
    //   graph_api("command","dot","data",adj,"nodeLabels",["label1","label2","label3"])
    //   graph_api("command","neato","data","dotfile.dot","output","image")
    //   graph_api("command","neato","data","dotfile.dot","output","image","addons",{"tred","unflatten"})
    //   [settings] = ]graph_api("command","dot","data",adj,"nodeLabels",["label1","label2","label3"],"output","plot")
    //   [settings,graphData] = graph_api("command","dot","data",adj,"nodeLabels",["label1","label2","label3"],"output","data")
    //   
    //   Parameters
    //   It uses "<Parameter>, <Value>" key value pair arguments. The parameter pair can be used in any order.
    //   command : dot/neato/fdp/sfdp/twopi/circo/patchwork/osage
    //   data : If type is "dot", then dot file path has to be given. Else adjacency matrix will be given.
    //   nodeLabels : node labels for given adjacency matrix(optional), if this argument is not given, then index numbers(1,2,3,...) will be used.
    //   output : Output type 'plot' or 'image' or "data"
    //           plot - It will generate a editable Scilab plot
    //           image - It will generate an image and fits in the Scilab axesH using IPCV toolbox commands "imread" and "imshow".
    //           data - It will return a data structure("graphData") which contains nodes and edge positions, adjacency matrix and node labels.
    //   addons : addons consists of two options which is used to improve the graph layouts. This can be used only with "dot" layout command.
    //            tred -  removes edges implied by transitivity.(Only for directed graphs)
    //            unflatten - improves the graph layouts aspect ratio.
    //   settings - Scilab plot related settings, useful to update the plot peoperties. Refer update_graph_plot for more details.
    //   graphData - It is a structure variable contains node and edge coordinates, generated adjacency matrix for the given DOT file, Graphviz output data.
    //
    //   Description
    //   graph_api is an API to invoke Scilab graph drawing functionality. 
    //   Helps to pass the Scilab data to Graphviz and retrive the results back to Scilab.
    //
    //   Examples
    //   // This below command use "dot" Graphviz layout command for the given DOT file and generates Scilab plot(default).
    //   dotFilePath = uigetfile(["*.dot";],'','Select the DOT file');
    //   graph_api("command","dot","data",dotFilePath)
    //
    //   Examples
    //   // This below command use "fdp" Graphviz layout command for the given DOT file and generates Image.
    //   dotFilePath = uigetfile(["*.dot";],'','Select the DOT file');
    //   graph_api("command","fdp","data",dotFilePath,'output','image')
    //
    //   Examples
    //   // This below command use "dot" Graphviz layout command and 'tred' add-ons for the given DOT file and generates Image.
    //   dotFilePath = uigetfile(["*.dot";],'','Select the DOT file');
    //   graph_api("command","fdp","data",'..\examples\coding_callgraph.dot','output','image','addons',{'tred'}) 
    //
    //   Examples
    //   // This below command use "dot" Graphviz layout command for the given DOT file and returns with Graphviz output data.
    //   dotFilePath = uigetfile(["*.dot";],'','Select the DOT file');
    //   [settings,graphData] = graph_api("command","dot","data",dotFilePath,'output','data','addons',{'tred','unflatten'});
    //

    // Input validation
    [data,command,nodeLabels,outputType,settings,add_ons] = processInputs(varargin(:))
    [dataType] = inputValidationGraphApi(data)
    if isempty(outputType)
        outputType = 'plot';
    elseif ~(isequal(convstr(outputType,'l'),'plot') || isequal(convstr(outputType,'l'),'image') || isequal(convstr(outputType,'l'),'data'))
        error('Unknown output parameter'); 
    end
    if isempty(settings) 
        // Default settings value.
        settings = struct();
        settings.fontSize = 1;
        settings.nodeShapeValue = 'Ellipse';
        settings.backGroundColor = 8;
        settings.foreGroundColor = 1;
        settings.fontColor = 1;
        settings.connectorType = 'Arrow';
        settings.connectorColor = 'Black';
    end
    if ~strcmp(dataType,'adj','i')
        [filename] = adjacency_to_dot(data,'adjacencyMatrix.dot',nodeLabels);
        fileCheck = 1;
    else
        // Handling different file formats.        
        fileExtension = fileext(data);
        if ~strcmp(fileExtension,'.gxl','i')
            filename = "gxl2gv.gv";
            try
                convert_graph_file(data,filename);
            catch
                error('Graphviz failure. Please check the inputs.'); 
            end            
            fileCheck = 1;
        elseif ~strcmp(fileExtension,'.gml','i')
            filename = "gml2gv.gv";
            try
                convert_graph_file(data,filename);
            catch
                error('Graphviz failure. Please check the inputs.'); 
            end            
            fileCheck = 1;
        elseif ~strcmp(fileExtension,'.csv','i')
            try
                [data,nodeLabels] = csv_to_adjacency(data);
            catch
                error('Cannot read csv file. Please check the inputs.'); 
            end
            [filename] = adjacency_to_dot(data,'adjacencyMatrix.dot',nodeLabels);
            fileCheck = 1;
        else
            filename = data;
            fileCheck = 0;
        end
    end

    add_ons_param = '';
    for ii = add_ons{:}
        if ~(~strcmp(ii,'tred','i') || ~strcmp(ii,'unflatten','i'))
            error('Unknown value for addons: expected ''tred or unflatten''');
        else
            add_ons_param = strcat([add_ons_param,'| ',ii,' ']);
        end
    end
    add_ons_param = strcat([add_ons_param,'|']);
    // Call Graphviz 
    [graphText,data] = callGraphviz(filename,command,outputType,add_ons_param);

    // Process as per the expected output type.
    if isequal(convstr(outputType,'l'),'image')
        if ~atomsIsInstalled('IPCV')
            error('Please install IPCV module to use image viewing.');
        end
        axesH = findobj('tag','GraphAxes');
        if isempty(axesH)
            axesH = gca();
        end
        sca(axesH); 
        delete(axesH.children);
        axesSize = axesH.Parent.position;
        set(axesH,'data_bounds',[0 0; 1 1]);
        set(axesH,'zoom_box',[]);
        imageData = imread('graphvizout.png');
        imageSize = size(imageData);
        imageLength = imageSize(2);
        imageHeight = imageSize(1);
        axesLength = axesSize(3);
        axesHeight = axesSize(4);
        // Find the scaling factor
        lengthRatio = axesLength/imageLength;
        heightRatio = axesHeight/imageHeight;
        minRatio = min(lengthRatio,heightRatio);
        imshow(imageData);
        axesLength = axesLength/minRatio;
        axesHeight = axesHeight/minRatio;
        set(axesH,'data_bounds',[0 0; axesLength axesHeight]);

        // Center the position of the image.
        xMove = axesLength/2 - imageLength/2;
        yMove = axesHeight/2 - imageHeight/2;
        set(axesH,'data_bounds',[-xMove -yMove; axesLength-xMove axesHeight-yMove]);
        deletefile('graphvizout.png');
    else
        // Parse Graphviz output and get the node and edge data.
        [nodeData,edgeData] = readDotFile(graphText);
        // Create a structure to sstore all graph datas
        graphData = struct();
        graphData.nodeData = nodeData;
        graphData.edgeData = edgeData;
        if ~strcmp(dataType,'adj','i')
            graphData.adjacencyMatrix = data;
        else
            graphData.adjacencyMatrix = dot_to_adjacency(data);
        end
        graphData.graphText = graphText;
        if isequal(convstr(outputType,'l'),'plot')
            axesH = findobj('tag','GraphAxes');
            if isempty(axesH)
                axesH = gca();
            end
            // Set graphData in axesH userdata
            set(axesH,"UserData",graphData);
            update_graph_plot(settings);
        end
    end
    // Delete file if it is created temporarily.
    if fileCheck
        deletefile(filename);
    end

    // Return graphData structure if its called.
    if nargout == 2 && isequal(convstr(outputType,'l'),'data')
        varargout(1) = settings;
        varargout(2) = graphData;
    elseif nargout == 1
        varargout(1) = settings;
    end

endfunction 
/*********************************************************************/
function [data,command,nodeLabels,outputType,settings,add_ons] = processInputs(varargin)
    // Process the inputs and perform error checking    

    labels = {"data","command","nodeLabels","output","settings","addons"};
    data = [];
    command = "dot";
    nodeLabels = "";
    outputType = "";
    settings = [];
    add_ons = {};
    for i = 1:2:length(varargin)
        arg = varargin(i);
        if ~strcmp(arg,labels{1},'i')
            data = varargin(i+1);
            if ~(~strcmp(typeof(data),'string') || ~strcmp(typeof(data),'constant'))
                error('Please Check the Value for Data parameter')
            end
        elseif ~strcmp(arg,labels{2},'i')
            command = varargin(i+1);
            if ~isletter(command) || isempty(command)
                error('Please Check the Value for command parameter');
            end
        elseif ~strcmp(arg,labels{3},'i')
            value = varargin(i+1);
            if ~isempty(value)
                if typeof(value) ~= 'string'

                    error('Please Check the Value for nodeLabels parameter');
                end
            end
            nodeLabels = value;
        elseif ~strcmp(arg,labels{4},'i')
            value = varargin(i+1);
            if typeof(value) ~= 'string'
                error('Please Check the Value for output parameter');
            end
            outputType = value;
        elseif ~strcmp(arg,labels{5},'i')
            value = varargin(i+1);
            if typeof(value) ~= 'st'
                error('Please Check the Value for settings parameter');
            end
            settings = value;
        elseif ~strcmp(arg,labels{6},'i')
            value = varargin(i+1);
            if ~iscellstr(value)
                error('Please Check the Value for addons parameter');
            end
            add_ons = value;
        end
    end

endfunction
/******************************************************************************/
function [graphText,filename] = callGraphviz(filename,command,outputType,add_ons_param)
    // Call the Graphviz tool
    if isempty(add_ons_param)
        baseCommand = strcat([command,' -Gmaxiter=5000 -Gstart=7 ',filename]);
    else
        baseCommand = strcat([command,' -Gmaxiter=5000 -Gstart=7 ',filename,add_ons_param,command,' ']);
    end
    if isequal(convstr(outputType,'l'),'plot') || isequal(convstr(outputType,'l'),'data')
        doscommand = strcat([baseCommand, ' -Tplain ']);
    elseif isequal(convstr(outputType,'l'),'image')
        doscommand = strcat([baseCommand, ' -Tpng -o graphvizout.png  -Tplain ']);
    end
    [graphText,errorValue] = unix_g(doscommand);
    if errorValue
        error('Graphviz failure. Please check the inputs.'); 
    end

endfunction
/******************************************************************************/
function [nodeData,edgeData] = readDotFile(graphText)
    // Parse the layout.dot file for the node locations and dimensions. 

    for ii = 1:size(graphText,1)
        value = strstr(graphText(ii),'graph');
        if ~isempty(value)
            splitedValue = strsplit(value," ");
            dimension = [splitedValue(3),splitedValue(4)]
            graphDimension = strtod(dimension);
            break
        end
    end

    // Get all node related details
    nodeLabel = [];
    nodeCenters = [];
    nodeSize = [];
    for ii = 1:size(graphText,1)
        getValue = strstr(graphText(ii),'node');

        if ~isempty(getValue)
            splitedValue = strsplit(graphText(ii)," ");
            nodeLabel = [nodeLabel splitedValue(2)];
            nodeXY = strtod([splitedValue(3),splitedValue(4)]);
            nodeWH = strtod([splitedValue(5),splitedValue(6)]);
            nodeCenters = [nodeCenters;nodeXY];
            nodeSize = [nodeSize; nodeWH];
        end
    end

    // Get all edge related details
    edgeData = [];
    for ii = 1:size(graphText,1)
        from = [];
        to = [];
        points = [];
        edgeValues = strstr(graphText(ii),'edge');
        if ~isempty(edgeValues)
            splitedValue = strsplit(graphText(ii)," ");
            from = [from splitedValue(2)];
            to = [to splitedValue(3)];
            numPoints = strtod(splitedValue(4));
            for jj = 1:numPoints
                points = [points; strtod([splitedValue(4+jj*2-1) splitedValue(4+jj*2)])];
            end
            edgeRecord = struct('from',from,'to',to,'points',points);
            edgeData = [edgeData; edgeRecord]
        end
    end

    nodeData = struct('nodeLabel',nodeLabel,'nodeCenters',nodeCenters,'nodeSize',nodeSize);

endfunction
/******************************************************************************/
function [dataType] = inputValidationGraphApi(data)
    // Find the input datatype - adjacency matrix  or dot file.

    if isequal(typeof(data),"constant")
        if ~issquare(data)
            error("Adjacency matrix should be a square matrix");
        else
            dataType = 'adj';
        end
    elseif isequal(typeof(data),"string")
        dataType = 'dot';
    else
        error("Value of data paramter - Adjacency Matrix or DOT filename is expected")
    end

endfunction
/******************************************************************************/
