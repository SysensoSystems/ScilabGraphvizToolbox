function outputMenuCallBack()
    // Get the output(Graph Plot/Image) menu value and set the property editor visibility.

    figH = findobj('Tag','graph_toolFigure');
    handles = get(figH,'user_data');

    outputMenuValue = get(handles.outputTypePopUpButton,'Value');
    if isequal(outputMenuValue,1)
        set(handles.propertyPanel,'Enable','on');
        set(handles.saveButton,'Enable','on');
    elseif isequal(outputMenuValue,2)
        set(handles.propertyPanel,'Enable','off');
        set(handles.saveButton,'Enable','off');
    end

endfunction
