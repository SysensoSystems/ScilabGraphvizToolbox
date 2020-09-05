function exportButtonCallback()
    // To export the current figure as image

    figH = findobj('Tag','graph_toolFigure');
    handles = get(figH,'user_data');

    outputType = get(handles.outputTypePopUpButton,'value');

    fileFormats = ["PPM image";"Windows BMP image";"GIF image";...
    "Enhanced Metafile Image";"SVG image";"PDF image";"PostScript Image";...
    "Encapsulated PostScript Image";"JPEG image";"PNG image"];
    [fileName,path,index] = uiputfile(fileFormats);

    extension = [".ppm",".bmp",".gif",".emf",".svg",".pdf",".ps",".eps",".jpeg",".png",".jpg"];
    if ~isempty(fileName)
        if isequal(index,11)
            fileExtension = fileext(fileName);
            tempCheck = 1;
            for ii = 1:size(extension,2)
                if ~strcmp(fileExtension,extension(ii),'i')
                    tempCheck = 0;
                    index = ii;
                end
            end
            if tempCheck
                messagebox("Unsupported File Format to save a figure","Error","error","modal");
                return
            end
            if isequal(index,11)
                index = 9;
            end
        end
        fileextension = fileext(fileName);
        axes = handles.axesH;
        data = axes.children.data;
        if ~isempty(fileextension)
            fileName = strsubst(fileName,fileextension,"");
        end
        if isequal(length(size(data)),3) && isequal(size(axes.children,1),1)
            data = axes.children.data;
            filePath = strcat([path,'\',fileName,extension(index)]);
            imwrite(data,filePath);
        else
            tempFigure = figure('visible','off');
            copy(axes,tempFigure);
            filePath = strcat([path,'\',fileName,extension(index)]);
            set(tempFigure,'visible','on');
            switch index
            case 1
                xs2ppm(tempFigure, filePath);
            case 2
                xs2bmp(tempFigure, filePath);
            case 3
                xs2gif(tempFigure, filePath);
            case 4
                xs2emf(tempFigure, filePath);
            case 5
                xs2svg(tempFigure, filePath);
            case 6
                xs2pdf(tempFigure, filePath);
            case 7
                xs2ps(tempFigure, filePath);
            case 8
                xs2eps(tempFigure, filePath);
            case 9
                xs2jpg(tempFigure, filePath,1);
            case 10
                xs2png(tempFigure, filePath);
            end
            delete(tempFigure);
        end
    else
        return
    end

endfunction
