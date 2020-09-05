function plotGraph(commandName)
    // Plots the Graph using graph_api

    figH = findobj('Tag','graph_toolFigure');
    handles = get(figH,'user_data');

    settings = struct();
    settings.fontSize = get(handles.fontEdit,'Value');
    settings.fontColor = get(handles.fontColor,'UserData');
    nodeShapeValue = get(handles.nodeShapePopup,'Value');
    nodeShapeString = get(handles.nodeShapePopup,'String');
    settings.nodeShapeValue = nodeShapeString(nodeShapeValue);
    settings.backGroundColor = get(handles.backGroundColor,'UserData');
    settings.foreGroundColor = get(handles.foreGroundColor,'UserData');
    connectorTypeValue = get(handles.connectorType,'Value');
    connectorTypeString = get(handles.connectorType,'String');
    settings.connectorType = connectorTypeString(connectorTypeValue);
    connectorColorValue = get(handles.connectorColor,'Value');
    connectorColorString = get(handles.connectorColor,'String');
    settings.connectorColor = connectorColorString(connectorColorValue);

    outputTypeIndex = get(handles.outputTypePopUpButton,'Value');
    if isequal(outputTypeIndex,1)
        outputType = 'plot';
    else
        outputType = 'image';
    end
    sca(handles.axesH); 
    delete(gca().children);
    radioValue = get(handles.browseRadio,'Value');
    if radioValue == 1        
        graphFilePath = get(handles.browseEdit,"String");
        if isempty(graphFilePath)
            messagebox("Select a .dot or .gv file","Error","error","modal");
            return
        end
        graph_api("command",commandName,"data",graphFilePath,"output",outputType,"settings",settings);
    else
        variableList = get(handles.matrixPopup,'String');
        variableIndex = get(handles.matrixPopup,'Value');
        variableName = variableList(variableIndex);
        nameList = get(handles.namePopup,'String');
        nameIndex = get(handles.namePopup,'Value');
        labelVariable = nameList(nameIndex);
        if ~strcmp(variableName,'<Select>','i')
            messagebox("Select a valid variable from the matrix popup menu","Error","error","modal");
            return
        end
        data = evstr(variableName);
        if strcmp(typeof(data),'constant','i')
            messagebox("Please select a variable containing adjacency matrix - Type Integer Array","Error","Eerror","modal");
            return
        end
        if ~strcmp(labelVariable,'<Select>','i')
            nodeLabels = [];
        else
            nodeLabels = evstr(labelVariable);
            if strcmp(typeof(nodeLabels),'String','i')
                messagebox("Please select a variable containing node labels - Type String","Error","Eerror","modal");
                return
            end
        end
        graph_api("command",commandName,"data",data,"nodeLabels",nodeLabels,"output",outputType,"settings",settings);
    end

endfunction
