// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

//==============================================================================
// Test case to check graph_tool GUI - Property editor work properly.

// Get the dot file path
try
    rootPath = getenv("scilab_graphviz_path");
catch
    unittestPath = get_absolute_file_path("graph_tool_property_editor.tst");
    unittestPath  = getshortpathname(unittestPath);
    rootPath = strncpy(unittestPath, length(unittestPath)-length("\tests\unit_tests\") );
end

dotFilePath = fullpath(rootPath + "/examples/coding_callgraph.dot");
// Plot a Graph form of dot file using graph_tool and change axes properties.
try
    handles = graph_tool();
    set(handles.browseEdit,'String',dotFilePath);
    set(handles.outputTypePopUpButton,'Value',1);
    callback = get(handles.dotButton,'Callback');
    gcbo = handles.dotButton;
    execstr(callback);
    set(handles.backGroundColor,'Userdata',3);
    set(handles.backGroundColor,'String','green');
    set(handles.fontColor,'Userdata',5);
    set(handles.fontColor,'String','red');
    applyButtonCallback = get(handles.applyButton,'Callback');
    execstr(applyButtonCallback);
    delete(handles.figH);
catch
    assert_generror("Error using graph_plot gui - Property Editor doesnt work properly");
end

//==============================================================================
