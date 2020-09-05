function variableRadioCallback()
    // Helps to enable file adjacency data related input options.

    figH = findobj('Tag','graph_toolFigure');
    handles = get(figH,'user_data');

    radioValue = get(handles.variableRadio,'Value');
    if radioValue == 1
        defaultValue = "<Select>";
        variableList = who_user(%f);
        popupList = cat(1,defaultValue,variableList);
        set(handles.browseRadio,'Value',0);
        set(handles.browseEdit,'Enable','off');
        set(handles.browseButton,'Enable','off');
        set(handles.matrixPopup,'Enable','on');
        set(handles.namePopup,'Enable','on');
        set(handles.matrixPopup,'String',popupList,'Value',1);
        set(handles.namePopup,'String',popupList,'Value',1);
    end

endfunction
