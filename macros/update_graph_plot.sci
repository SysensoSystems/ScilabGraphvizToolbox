// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

function update_graph_plot(settings)
    //   Updates the Scilab plot with the given property settings.
    //
    //   Syntax
    //   update_graph_plot(settings)
    //
    //   Parameters
    //   settings : Settings will have properties as shown below.
    //              settings = struct();
    //              settings.fontSize = 1;
    //              settings.nodeShapeValue = 'Circle';
    //              settings.backGroundColor = 8;
    //              settings.foreGroundColor = 1;
    //              settings.fontColor = 1;
    //              settings.connectorType = 'Arrow';
    //              settings.connectorColor = 'Black';
    //
    //   Description
    //   It is useful to update the Scilab plot which was generated using graph_api.
    //
    //   Examples
    //   // Sample use case: By using "graph_api", Scilab plot can be generated for the given DOT file.
    //   // Then using the settings data, the plot properties can be updated.
    //   dotFilePath = uigetfile(["*.dot";],'','Select the DOT file');
    //   graph_api("command","dot","data",dotFilePath,'output','plot')
    //   settings = graph_api("command","dot","data",dotFilePath,'output','data')
    //   settings.nodeShapeValue = 'Point';
    //   settings.fontSize = 3;
    //   update_graph_plot(settings);
    //

    // Get the axes to plot
    axesH = findobj('tag','GraphAxes');
    if isempty(axesH)
        axesH = gca();
    end
    graphData = get(axesH,"UserData");
    nodeData = graphData.nodeData;
    edgeData = graphData.edgeData;
    sca(axesH); 
    delete(axesH.children);
    set(axesH,'data_bounds',[0 0; 1 1]);
    set(axesH,'zoom_box',[]);

    //Input Validation
    settings = inputValidation(settings)

    //Set axes limit to fit all the componenets.
    axesSize = axesH.Parent.position;
    splitedValue = strtod(strsplit(graphData.graphText(1,:)," "));
    imageLength = splitedValue(3);
    imageHeight = splitedValue(4);
    axesLength = 1;
    axesHeight = axesSize(4)/axesSize(3);

    // Find the scaling factor
    lengthRatio = axesLength/imageLength;
    heightRatio = axesHeight/imageHeight;
    minRatio = min(lengthRatio,heightRatio);

    // Draw the node and edges in the axes.
    drawNodes(nodeData,axesH,settings);
    drawEdges(nodeData,edgeData,axesH,settings);

    // Adjust the axes bounds with the scaling factor
    axesLength = axesLength/minRatio;
    axesHeight = axesHeight/minRatio;
    dataBounds = axesH.data_bounds;
    set(axesH,'data_bounds',[dataBounds(1,1) dataBounds(1,2); axesLength axesHeight]);

    // Center the position of the image.
    xMove = axesLength/2 - imageLength/2;
    yMove = axesHeight/2 - imageHeight/2;
    set(axesH,'data_bounds',[(dataBounds(1,1)-xMove) (dataBounds(1,2)-yMove); (axesLength-xMove) (axesHeight-yMove)]);

endfunction
/******************************************************************************/
function [settings] = inputValidation(settings)
    // Validate the setting data.

    if typeof(settings) ~= 'st'
        error('Settings parameter should of type structure');
    end
    unavailablFields = [];
    fields = ["fontSize","nodeShapeValue","backGroundColor","foreGroundColor","fontColor",...
    "connectorType","connectorColor"];
    types = ["constant","string","constant","constant","constant","string","string"];
    defaultValues = {1,'Circle',8,1,1,'Arrow','Black'};
    for ii = 1:size(fields,2)
        if isfield(settings,fields(ii))
            value = settings(fields(ii));
            if typeof(value) ~= types(ii)
                message = strcat([fields(ii),' field should be of type ',types(ii)]);
                error(message)
            end
        else
            settings(fields(ii)) = defaultValues{ii};
        end
    end

endfunction
/******************************************************************************/
function drawNodes(nodeData,axesH,settings)
    // draw nodes in graph

    nodeCenters = nodeData.nodeCenters;
    nodeSize = nodeData.nodeSize;
    fontSize = settings.fontSize;
    fontColor = settings.fontColor;
    nodeShape = convstr(settings.nodeShapeValue,'l');
    foreGroundColor = settings.foreGroundColor;
    backGroundColor = settings.backGroundColor;
    if isempty(backGroundColor)
        backGroundColor = 8;
    end
    if isempty(foreGroundColor)
        foreGroundColor = 1;
    end
    switch nodeShape
    case 'points'
        for i = 1:size(nodeCenters,1)
            xpos = nodeCenters(i,1);
            ypos = nodeCenters(i,2);
            plotH = plot(xpos,ypos,'.o');
            plotH.fill_mode = 'on';
            plotH.mark_background = backGroundColor;
            plotH.mark_foreGround = foreGroundColor;
        end
    case 'ellipse'
        for i = 1:size(nodeCenters,1)
            xpos = nodeCenters(i,1);
            ypos = nodeCenters(i,2);
            width = nodeSize(i,1);
            height = nodeSize(i,2);
            upperX = xpos - width/2;
            upperY = ypos + height/2;
            xarc(upperX, upperY, width, height, 0, 360*64)
            currentPlotH = gce();
            currentPlotH.fill_mode = 'on';
            currentPlotH.background = backGroundColor;
            currentPlotH.foreGround = foreGroundColor;
        end
    case 'circle'
        for i = 1:size(nodeCenters,1)
            xpos = nodeCenters(i,1);
            ypos = nodeCenters(i,2);
            radius = nodeSize(1)/2;
            th = linspace(0, 2*%pi, 100);
            xunit = radius * cos(th) + xpos;
            yunit = radius * sin(th) + ypos;
            plotH = plot(xunit,yunit);
            plotH.fill_mode = 'on';
            plotH.background = backGroundColor;
            plotH.foreGround = foreGroundColor;
        end
    case 'rectangle'    
        for i = 1:size(nodeCenters,1)
            xrect(nodeCenters(i,1)-nodeSize(i,1)/2,nodeCenters(i,2)+nodeSize(i,2)/2,nodeSize(i,1),nodeSize(i,2));
            currentPlotH = gce();
            currentPlotH.fill_mode = 'on';
            currentPlotH.background = backGroundColor;
            currentPlotH.foreGround = foreGroundColor;
        end
    end
    axesH.axes_visible="off";
    if isempty(fontColor)
        fontColor = 1;
    end
    // Draw the node's label    
    nodeCenters = nodeData.nodeCenters;
    nodeLabel = nodeData.nodeLabel;
    for ii = 1:size(nodeCenters,1)
        xpos = nodeCenters(ii,1);
        ypos = nodeCenters(ii,2); 
        len = length(nodeLabel(ii));
        xstring(xpos,ypos,nodeLabel(ii))
        text = get("hdl");
        text.font_size = fontSize;
        text.font_foreground = fontColor;
        text.text_box_mode = 'centered' ;
    end
    axesH.axes_visible="off";

endfunction
/******************************************************************************/
function drawEdges(nodeData,edgeData,axesH,settings)
    // Draw the specified edges. 

    connectorType = settings.connectorType;
    connectorColor = settings.connectorColor;
    nodeShape = convstr(settings.nodeShapeValue,'l');
    colorIndex = color(connectorColor);
    if ~strcmp(nodeShape,'points','i')
        nodeCenters = nodeData.nodeCenters;
        nodeLabel = nodeData.nodeLabel;
        for ii = 1:length(edgeData)
            from = edgeData(ii).from;
            to = edgeData(ii).to;
            for jj = 1:size(nodeCenters,1)
                if ~strcmp(from,nodeLabel(jj))
                    fromxpos = nodeCenters(jj,1);
                    fromypos = nodeCenters(jj,2);
                end
                if ~strcmp(to,nodeLabel(jj))
                    toxpos = nodeCenters(jj,1);
                    toypos = nodeCenters(jj,2);
                end
            end
            X = [fromxpos toxpos];
            Y = [fromypos toypos];
            lineFormat = strcat(['-' convstr(connectorColor,'l')]);
            if ~strcmp(connectorType,'arrow','i')
                xarrows(X,Y,1,colorIndex)
            else
                plot(X,Y,lineFormat)
            end
        end
    else
        for ii = 1:length(edgeData)
            points = edgeData(ii).points
            X = points(:,1);
            Y = points(:,2);
            lineFormat = strcat(['-' convstr(connectorColor,'l')]);
            if ~strcmp(connectorType,'arrow','i')
                plot(X,Y,lineFormat)
                xarrows(X([length(X)-1 length(X)] ),Y([length(Y)-1, length(Y)]),2,colorIndex)
            else
                plot(X,Y,lineFormat)
            end
        end
    end
    axesH.axes_visible="off";

endfunction
/******************************************************************************/
