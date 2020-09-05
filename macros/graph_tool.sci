// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

function varargout = graph_tool()
    //   graph_tool - Utility to plot adjacency matrix or the graph file using Graphviz APIs.
    //
    //   Syntax
    //   graph_tool
    //   handles = graph_tool()
    //   
    //   Parameters
    //   handles : GUI handles to get access to the GUI components.
    //   
    //   Description
    //   Utility to plot adjacency matrix or the graph file using Graphviz APIs.
    //   It supports various graph file formats: .gv, .dot, .gml, .gxl.
    //   It has following features.
    //      - View the generated graph image file
    //         * It requires "Image Processing and Computer Vision Toolbox" for Scilab.
    //         * If it is not installed earlier, install it using the command in Scilab console as -->atomsInstall("IPCV") 
    //      - Features to edit the graph generated in Scilab axes
    //      - Different layout algorithms available in Graphviz, that can be used from the GUI.
    //      - Export/Save into different file formats.
    //
    //   Refer DEMOs for more usecases and information.

    // Create the GUI components and setup the callbacks for the Scilab graph drawing Tool GUI.    
    // Get the screen size and place the gui to an appropriate size to the screen.
    scrsz = get(0,'screensize_px');
    screensize_factor = 0.6;
    screensize_factor_1 = 0.8;
    screensize_factor_2 =0.9;
    figsize = [(scrsz(3)*(1-screensize_factor))/2 (scrsz(4)*(1-screensize_factor_2))/2 scrsz(3)*screensize_factor scrsz(4)*screensize_factor_1];
    handles.figH = figure('Name','Scilab Graph Tool','Position',figsize,'layout','gridbag','Tag','graph_toolFigure','figure_id',1,'Visible','off');

    // constraints = createConstraints("gridbag", grid, weight, fill, anchor, padding, preferredsize)
    browseGrid = createConstraints("gridbag",[0, 0, 3, 1], [0,0],"both","center", [5,5], [100, 25]);
    browseEmptyGrid = createConstraints("gridbag",[0, 1, 3, 1], [0,0],"both","center", [5,5], [100, 20]);
    matrixGrid = createConstraints("gridbag",[0, 2, 3, 1], [0,0],"both","center", [5,5], [100, 70]);
    matrixEmptyGrid = createConstraints("gridbag",[0, 3, 3, 1], [0,0],"both","center", [5,5], [100, 20]);
    layoutOptionsGrid = createConstraints("gridbag",[0, 4, 2, 1], [0, 0], "both", "center", [1,1], [50, 50]);
    axesGrid = createConstraints("gridbag",[0, 5, 2, 2], [3, 3], "both", "center", [5, 5], [-1, -1]);
    saveFigureGrid = createConstraints("gridbag",[0, 7, 2, 1], [0, 0], "both", "center", [1,1], [50, 25]);
    propertyGrid = createConstraints("gridbag",[2, 4, 1, 4], [1,1], "both", "center", [5, 5], [-1, -1]);
    componentsGrid = createConstraints("grid");
    emptyBorder = createBorder("empty");
    uicontrol(handles.figH,"style","frame","layout","gridbag","border",emptyBorder,"constraints", browseEmptyGrid);
    uicontrol(handles.figH,"style","frame","layout","gridbag","border",emptyBorder,"constraints", matrixEmptyGrid);

    // Browse panel components
    handles.browsePanel = uicontrol(handles.figH,"style","frame","layout","gridbag","border",emptyBorder,"constraints", browseGrid);
    commanGrid = createConstraints("gridbag",[0,1,1,1],[0.5,0.5], "both", "center", [9.7, 9.7], [1, 1]);

    radioButtonGrid = uicontrol(handles.browsePanel,"style", "frame","layout","grid","constraints", commanGrid);
    commanGrid = createConstraints("gridbag",[2,1,7,7],[6,6], "both", "center", [0, 0], [1, 1]);
    editGrid = uicontrol(handles.browsePanel,"style", "frame","layout","grid","constraints", commanGrid);
    commanGrid = createConstraints("gridbag",[9,1,1,1],[0.1,0.1], "both", "center", [0, 0], [1, 1]);
    uicontrol(handles.browsePanel,"style", "frame","layout","grid","constraints", commanGrid);
    commanGrid = createConstraints("gridbag",[10,1,1,1],[0.5,0.5], "both", "center", [0, 0], [1, 1]);
    browseButtonGrid = uicontrol(handles.browsePanel,"style", "frame","layout","grid","constraints", commanGrid);

    handles.browseRadio = uicontrol("Parent",radioButtonGrid,"Style","radiobutton","HorizontalAlignment","center","String",'',"constraints",componentsGrid);
    handles.browseEdit = uicontrol("Parent",editGrid,"Style","edit","String","","constraints",componentsGrid);
    handles.browseButton = uicontrol("Parent",browseButtonGrid,"Style","pushbutton","String","Browse","constraints",componentsGrid);

    // Matrix Panel Components
    handles.matrixPanel = uicontrol(handles.figH,"style","frame","layout","gridbag","border",emptyBorder,"constraints", matrixGrid);
    commanGrid = createConstraints("gridbag",[0,1,1,1],[0.537,0.537], "both", "center", [0, 0], [1, 1]);
    radioButtonGrid = uicontrol(handles.matrixPanel,"style", "frame","layout","grid","constraints", commanGrid);
    commanGrid = createConstraints("gridbag",[2,1,7,7],[5.95,5.95], "both", "center", [0, 0], [-1, -1]);
    popupGrid = uicontrol(handles.matrixPanel,"style", "frame","layout","gridbag","constraints", commanGrid);
    commanGrid = createConstraints("gridbag",[9,1,1,1],[0.05,0.05], "both", "center", [0, 0], [1, 1]);
    emptyGrid = uicontrol(handles.matrixPanel,"style", "frame","layout","grid","constraints", commanGrid);
    commanGrid = createConstraints("gridbag",[10,1,1,1],[0.55,0.55], "both", "center", [0, 0], [1, 1]);
    emptyGrid = uicontrol(handles.matrixPanel,"style", "frame","layout","grid","constraints", commanGrid);
    layoutOption = createLayoutOptions("grid", [3,1],[0,0]);
    set(radioButtonGrid,"layout_options",layoutOption);

    uicontrol("Parent",radioButtonGrid,"Style","text","HorizontalAlignment","center","String","Output","constraints",componentsGrid);
    uicontrol("Parent",radioButtonGrid,"Style","text","HorizontalAlignment","center","String","","constraints",componentsGrid);
    handles.variableRadio = uicontrol("Parent",radioButtonGrid,"Style","radiobutton","HorizontalAlignment","center","String",'',"constraints",componentsGrid);
    // Popup Grid components
    commanGrid = createConstraints("gridbag",[0,1,1,1],[0.5,0.5], "both", "center", [0, 0], [1, 1]);
    labelGrid = uicontrol(popupGrid,"style", "frame","layout","grid","constraints", commanGrid,"layout_options",layoutOption);
    commanGrid = createConstraints("gridbag",[2,1,2,2],[2,2], "both", "center", [0, 0], [1, 1]);
    matrixPopupGrid = uicontrol(popupGrid,"style", "frame","layout","grid","constraints", commanGrid,"layout_options",layoutOption);
    commanGrid = createConstraints("gridbag",[4,1,1,1],[0.5,0.5], "both", "center", [0, 0], [1, 1]);
    label2PopupGrid = uicontrol(popupGrid,"style", "frame","layout","grid","constraints", commanGrid,"layout_options",layoutOption);
    commanGrid = createConstraints("gridbag",[5,1,2,2],[2,2], "both", "center", [0, 0], [1, 1]);
    namePopupGrid = uicontrol(popupGrid,"style", "frame","layout","grid","constraints", commanGrid,"layout_options",layoutOption);

    handles.outputTypePopUpButton = uicontrol("Parent",labelGrid,"Style","popupmenu","String",["Graph Plot","Image"],"value",1,"constraints",componentsGrid);
    uicontrol("Parent",labelGrid,"Style","text","HorizontalAlignment","center","String","","constraints",componentsGrid);
    uicontrol("Parent",labelGrid,"Style","text","HorizontalAlignment","center","String","Matrix","constraints",componentsGrid);
    uicontrol("Parent",matrixPopupGrid,"Style","text","HorizontalAlignment","left","String","","constraints",componentsGrid);
    uicontrol("Parent",matrixPopupGrid,"Style","text","HorizontalAlignment","center","String","","constraints",componentsGrid);
    handles.matrixPopup = uicontrol("Parent",matrixPopupGrid,"Style","popupmenu","String","","constraints",componentsGrid);
    uicontrol("Parent",label2PopupGrid,"Style","text","HorizontalAlignment","left","String","","constraints",componentsGrid);
    uicontrol("Parent",label2PopupGrid,"Style","text","HorizontalAlignment","center","String","","constraints",componentsGrid);
    uicontrol("Parent",label2PopupGrid,"Style","text","HorizontalAlignment","center","String","Name","constraints",componentsGrid);
    uicontrol("Parent",namePopupGrid,"Style","text","HorizontalAlignment","left","String","","constraints",componentsGrid);
    uicontrol("Parent",namePopupGrid,"Style","text","HorizontalAlignment","center","String","","constraints",componentsGrid);
    handles.namePopup = uicontrol("Parent",namePopupGrid,"Style","popupmenu","String","Hi","constraints",componentsGrid);

    // Layout Panel Components
    border = createBorder('titled','Layout Options');
    handles.layoutOptionsPanel = uicontrol(handles.figH,"style","frame","layout","grid","border",border,"constraints",layoutOptionsGrid);
    layoutOption = createLayoutOptions("grid", [1,8],[5,5]);
    set(handles.layoutOptionsPanel,"layout_options",layoutOption);
    handles.osageButton = uicontrol(handles.layoutOptionsPanel,"style","pushbutton","string","osage","constraints",componentsGrid,'Tag','osage',...
    'TooltipString','Cluster structure');
    handles.patchWorkButton = uicontrol(handles.layoutOptionsPanel,"style","pushbutton","string","patchwork","constraints",componentsGrid,'Tag','patchwork',...
    'TooltipString','Squarified treemap');
    handles.circoButton = uicontrol(handles.layoutOptionsPanel,"style","pushbutton","string","circo","constraints",componentsGrid,'Tag','circo',...
    'TooltipString','Circular Layout');
    handles.twopiButton = uicontrol(handles.layoutOptionsPanel,"style","pushbutton","string","twopi","constraints",componentsGrid,'Tag','twopi',...
    'TooltipString','Radial Layout');
    handles.sfdpButton = uicontrol(handles.layoutOptionsPanel,"style","pushbutton","string","sfdp","constraints",componentsGrid,'Tag','sfdp',...
    'TooltipString','Spring Layout(Multiscale)');
    handles.fdpButton = uicontrol(handles.layoutOptionsPanel,"style","pushbutton","string","fdp","constraints",componentsGrid,'Tag','fdp',...
    'TooltipString','Spring Layout(Reducing Forces)');
    handles.neatoButton = uicontrol(handles.layoutOptionsPanel,"style","pushbutton","string","neato","constraints",componentsGrid,'Tag','neato',...
    'TooltipString','Spring Layout(Minimum Energy)');
    handles.dotButton = uicontrol(handles.layoutOptionsPanel,"style","pushbutton","string","dot","constraints",componentsGrid,'Tag','dot',...
    'TooltipString','Hierarchical Layout');

    // Axes panel components
    handles.axesPanel = uicontrol(handles.figH,"style","frame","layout","gridbag","border",emptyBorder,"constraints", axesGrid);
    handles.axesH = newaxes(handles.axesPanel);
    set(handles.axesH,"margins",[0.01 , 0.01, 0.01, 0.01],'tag','GraphAxes');

    // Property panel components
    border = createBorder('titled','Property Editor')
    handles.propertyPanel = uicontrol(handles.figH,"style","frame","layout","gridbag","border",border ,"constraints", propertyGrid);
    propertPanelGrid = createConstraints("gridbag",[0, 1, 1, 1], [0,0], "both", "center", [5, 5], [20,300]);
    advancedButtonGrid = createConstraints("gridbag",[0, 2, 1, 1], [0,0], "both", "center", [5, 5], [20,20]);
    emptyGrid = createConstraints("gridbag",[0, 3, 1, 1], [1,1], "both", "center", [5, 5], [-1, -1]);
    applyPanelGrid = createConstraints("gridbag",[0, 4, 1, 1], [0,0], "both", "center", [5, 5], [20,20]);
    uicontrol(handles.propertyPanel,"style","frame","layout","gridbag","constraints", emptyGrid);
    layoutOption = createLayoutOptions("grid", [1,3],[10,10]);
    handles.applyPanel = uicontrol(handles.propertyPanel,"style","frame","layout","grid","constraints", applyPanelGrid,"layout_options",layoutOption);
    handles.settingsPanel = uicontrol(handles.propertyPanel,"style","frame","layout","gridbag","constraints", propertPanelGrid);
    handles.advancedButtonPanel = uicontrol(handles.propertyPanel,"style","frame","layout","grid","constraints", advancedButtonGrid,"layout_options",layoutOption);
    layoutOption = createLayoutOptions("grid", [8,1],[10,10]);
    commanGrid = createConstraints("gridbag",[0,1,1,1],[1,1], "both", "center", [5, 5], [-1,-1]);
    labelGrid = uicontrol(handles.settingsPanel,"style", "frame","layout","grid","constraints",commanGrid,"layout_options",layoutOption);
    commanGrid = createConstraints("gridbag",[2,1,4,4],[2,2], "both", "center", [5, 5], [-1,-1]);
    popupGrid = uicontrol(handles.settingsPanel,"style", "frame","layout","grid","constraints",commanGrid,"layout_options",layoutOption);
    uicontrol(labelGrid,"Style","text","HorizontalAlignment","center","String","Connector Color","constraints",componentsGrid);
    uicontrol(labelGrid,"Style","text","HorizontalAlignment","center","String","Connector Type","constraints",componentsGrid);
    uicontrol(labelGrid,"Style","text","HorizontalAlignment","center","String","Node Shape","constraints",componentsGrid);
    uicontrol(labelGrid,"Style","text","HorizontalAlignment","center","String","Node ForegroundColor","constraints",componentsGrid);
    uicontrol(labelGrid,"Style","text","HorizontalAlignment","center","String","Node BackgroundColor","constraints",componentsGrid);
    uicontrol(labelGrid,"Style","text","HorizontalAlignment","center","String","Font Color","constraints",componentsGrid);
    uicontrol(labelGrid,"Style","text","HorizontalAlignment","center","String","Font Size","constraints",componentsGrid);
    colors = ["Black","Blue","Green","Cyan","Red","Magenta","Yellow"];
    handles.connectorColor = uicontrol(popupGrid,"Style","popupmenu","String",colors,"value",1,"constraints",componentsGrid);
    handles.connectorType = uicontrol(popupGrid,"Style","popupmenu","String",["Arrow","Normal"],"value",1,"constraints",componentsGrid);
    handles.nodeShapePopup = uicontrol(popupGrid,"Style","popupmenu","String",["Ellipse","Points","Circle","Rectangle"],"value",1,"constraints",componentsGrid);
    handles.foreGroundColor = uicontrol(popupGrid,"Style","pushbutton","String","black","constraints",componentsGrid);
    handles.backGroundColor = uicontrol(popupGrid,"Style","pushbutton","String","white","constraints",componentsGrid);
    handles.fontColor = uicontrol(popupGrid,"Style","pushbutton","String","black","constraints",componentsGrid);
    handles.fontEdit = uicontrol(popupGrid,"Style","spinner","String","",'Min',1,'Max',10,'SliderStep',[1,1],"constraints",componentsGrid);
    uicontrol(handles.advancedButtonPanel,"Style","text","HorizontalAlignment","center","String","","constraints",componentsGrid);
    handles.advancedButon = uicontrol(handles.advancedButtonPanel,"Style","pushbutton","HorizontalAlignment","center","String","Advanced","constraints",componentsGrid);
    uicontrol(handles.advancedButtonPanel,"Style","text","HorizontalAlignment","center","String","","constraints",componentsGrid);
    uicontrol(handles.applyPanel,"Style","text","HorizontalAlignment","center","String","","constraints",componentsGrid);
    handles.applyButton = uicontrol(handles.applyPanel,"Style","pushbutton","HorizontalAlignment","center","String","Apply","constraints",componentsGrid);
    uicontrol(handles.applyPanel,"Style","text","HorizontalAlignment","center","String","","constraints",componentsGrid);

    // Save Figure panel components
    handles.saveFigurePanel = uicontrol(handles.figH,"style","frame","layout","gridbag","constraints", saveFigureGrid);

    commanGrid = createConstraints("gridbag",[0,1,1,1],[4,4], "both", "center", [9.7, 9.7], [-1, -1]);
    uicontrol(handles.saveFigurePanel,"style", "frame","layout","grid","constraints", commanGrid);
    commanGrid = createConstraints("gridbag",[1,1,1,1],[1,1], "both", "center", [0, 0], [1, 1]);
    saveButtonFrame = uicontrol(handles.saveFigurePanel,"style", "frame","layout","grid","constraints", commanGrid);
    commanGrid = createConstraints("gridbag",[2,1,1,1],[0.5,0.5], "both", "center", [0, 0], [-1, -1]);
    uicontrol(handles.saveFigurePanel,"style", "frame","layout","grid","constraints", commanGrid);
    commanGrid = createConstraints("gridbag",[3,1,1,1],[1,1], "both", "center", [0, 0], [1, 1]);
    exportButtonFrame = uicontrol(handles.saveFigurePanel,"style", "frame","layout","grid","constraints", commanGrid);
    commanGrid = createConstraints("gridbag",[4,1,1,1],[4,4], "both", "center", [0, 0], [-1, -1]);
    uicontrol(handles.saveFigurePanel,"style", "frame","layout","grid","constraints", commanGrid);

    handles.saveButton = uicontrol("Parent",saveButtonFrame,"Style","pushbutton","String","Save As","constraints",componentsGrid);
    handles.exportButton = uicontrol("Parent",exportButtonFrame,"Style","pushbutton","String","Export To","constraints",componentsGrid);

    // Set callbacks and the userdata
    set(handles.figH,'user_data',handles);
    set(handles.browseButton,'Callback','browseFileCallback()');
    set(handles.browseRadio,'Callback','browseRadioCallback()');
    set(handles.variableRadio,'Callback','variableRadioCallback()');
    set(handles.dotButton,'Callback','plotCallback()');
    set(handles.neatoButton,'Callback','plotCallback()');
    set(handles.fdpButton,'Callback','plotCallback()');
    set(handles.sfdpButton,'Callback','plotCallback()');
    set(handles.twopiButton,'Callback','plotCallback()');
    set(handles.circoButton,'Callback','plotCallback()');
    set(handles.patchWorkButton,'Callback','plotCallback()');
    set(handles.osageButton,'Callback','plotCallback()');
    set(handles.applyButton,'Callback','applyButtonCallback()');
    set(handles.outputTypePopUpButton,'Callback','outputMenuCallBack()');
    set(handles.foreGroundColor,'Callback','getColorCallback(1)');
    set(handles.backGroundColor,'Callback','getColorCallback(8)');
    set(handles.fontColor,'Callback','getColorCallback(1)');
    set(handles.advancedButon,'Callback','advancedButtonCallback()');
    set(handles.saveButton,'Callback','saveButtonCallback()');
    set(handles.exportButton,'Callback','exportButtonCallback()');
    set(handles.axesPanel,'UserData',[]);
    set(handles.backGroundColor,'UserData',8);
    set(handles.foreGroundColor,'UserData',1);
    set(handles.fontColor,'UserData',1);
    set(handles.browseButton,'UserData',[]);

    // Set the default value 
    set(handles.browseRadio,'Value',1);
    browseRadioCallback();
    set(handles.figH,'Visible','on');

    // Return GUI handles structure.
    if nargout == 1 
        varargout(1) = handles;
    end

endfunction
