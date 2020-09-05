// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

//==============================================================================
// Test case to check graph_tool callbacks work properly.

// Get the dot file path
try
    rootPath = getenv("scilab_graphviz_path");
catch
    unittestPath = get_absolute_file_path("graph_tool_callback.tst");
    unittestPath  = getshortpathname(unittestPath);
    rootPath = strncpy(unittestPath, length(unittestPath)-length("\tests\unit_tests\") );
end

dotFilePath = fullpath(rootPath + "/examples/coding_callgraph.dot");
// Show Graph and Image form of dot file using graph_tool
try
    handles = graph_tool();
    set(handles.browseEdit,'String',dotFilePath);
    set(handles.outputTypePopUpButton,'Value',1);
    callback = get(handles.dotButton,'Callback');
    gcbo = handles.dotButton;
    execstr(callback);
    set(handles.outputTypePopUpButton,'Value',2);
    execstr(callback);
    delete(handles.figH);
catch
    assert_generror("Error using graph_plot gui");
end

//==============================================================================
