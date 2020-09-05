function getColorCallback(initColor)
    // Get the color and set background color of pushutton

    figH = findobj('Tag','graph_toolFigure');
    handles = get(figH,'user_data');

    buttonH = gcbo;
    colorIndex = getcolor('Select',initColor);
    if isempty(colorIndex) 
        colorIndex = initColor; 
    end
    colorArray = get(sdf(),"color_map");
    set(buttonH,'userdata',colorIndex);
    colorNames = rgb2name(colorArray(colorIndex,:)*255);
    set(buttonH,'String',colorNames(1));

endfunction
