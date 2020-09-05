function applyButtonCallback()
    // Apply button callack to apply graph properties to the Scilab plot

    figH = findobj('Tag','graph_toolFigure');
    handles = get(figH,'user_data');

    userData = get(handles.axesPanel,'UserData');
    if isempty(userData)
        return
    end
    commandName = userData;
    plotGraph(commandName);

endfunction
