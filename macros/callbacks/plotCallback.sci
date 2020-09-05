function plotCallback()
    // Common callback for all the plot/layout buttons

    figH = findobj('Tag','graph_toolFigure');
    handles = get(figH,'user_data');

    buttonH = gcbo;
    commandName = get(buttonH,'tag');
    plotGraph(commandName)
    userData = [commandName];
    set(handles.axesPanel,'UserData',userData);

endfunction
