function browseFileCallback()
    // Helps to browse the .gv/.dot/.gml/.gxl/.csv file

    figH = findobj('Tag','graph_toolFigure');
    handles = get(figH,'user_data');

    graphFilePath = uigetfile(["*.csv";"*.gxl";"*.gml";"*.gv";"*.dot"],'','Select the graph file');
    if isempty(graphFilePath)
        userData = get(handles.browseButton,'UserData');
        if ~isempty(userData)
            set(handles.browseEdit,"String",userData);
        end
    else
        set(handles.browseEdit,"String",graphFilePath);
        set(handles.browseButton,'UserData',graphFilePath);
    end
    
endfunction
