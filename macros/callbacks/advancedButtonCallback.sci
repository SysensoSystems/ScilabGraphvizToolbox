function advancedButtonCallback()
    // To open a advanced Axes editor dialog box

    figH = findobj('Tag','graph_toolFigure');
    handles = get(figH,'user_data');

    fignum = get(handles.figH,'figure_id');
    ged(9,fignum);

endfunction
