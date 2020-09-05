function saveButtonCallback()
    // To save the current figure in "*.scg" file

    figH = findobj('Tag','graph_toolFigure');
    handles = get(figH,'user_data');
    axes = handles.axesH;
    data = axes.children.data;
    if isequal(length(size(data)),3) && isequal(size(axes.children,1),1)
        messagebox("Unable to save Image to "".scg"" file ","Error","error","modal");
        return
    end
    [fileName,path,index] = uiputfile(["*.scg"]);
    if ~isempty(fileName)
        if isequal(index,2)
            extension = fileext(fileName);
            if strcmp(extension,'.scg','i')
                messagebox("Supported File Format to save is "".scg"" ","Error","error","modal");
                return
            end
        end
        tempFigure = figure('visible','off');
        copy(axes,tempFigure);
        extension = fileext(fileName);

        if ~isempty(extension)
            fileName = strsubst(fileName,extension,"");
        end
        filePath = strcat([path,'\',fileName,'.scg']);
        set(tempFigure,'visible','on');
        save(filePath,'tempFigure');
        delete(tempFigure);
    else
        return
    end

endfunction
