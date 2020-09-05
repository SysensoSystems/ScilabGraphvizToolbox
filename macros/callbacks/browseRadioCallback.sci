function browseRadioCallback()
    // Helps to enable file browsing options.

    figH = findobj('Tag','graph_toolFigure');
    handles = get(figH,'user_data');

    radioValue = get(handles.browseRadio,'Value');
    if radioValue == 1
        set(handles.variableRadio,'Value',0);
        set(handles.browseEdit,'Enable','on');
        set(handles.browseButton,'Enable','on');
        set(handles.matrixPopup,'Enable','off');
        set(handles.namePopup,'Enable','off');
    end

endfunction
