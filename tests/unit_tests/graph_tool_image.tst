// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

//==============================================================================
// Test case to check graph_tool GUI work properly.

// Initial test data
load imageData;

// Get the dot file path
try
    rootPath = getenv("scilab_graphviz_path");
catch
    unittestPath = get_absolute_file_path("graph_tool_image.tst");
    unittestPath  = getshortpathname(unittestPath);
    rootPath = strncpy(unittestPath, length(unittestPath)-length("\tests\unit_tests\") );
end

dotFilePath = fullpath(rootPath + "/examples/coding_callgraph.dot");
// Processes the dot file using graph_tool
handles = graph_tool();
set(handles.browseEdit,'String',dotFilePath);
set(handles.outputTypePopUpButton,'Value',2);
callback = get(handles.dotButton,'Callback');
gcbo = handles.dotButton;
execstr(callback);
//
// Get the image data from axes
axes = gca();
axesData = axes.children.data;
delete(handles.figH);

// Check if there are equal
flag = assert_checkequal(axesData,data);

//==============================================================================
