// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

//==============================================================================
// Test case to check graph_api, "plot" output action works properly.

// Get the dot file path
try
    rootPath = getenv("scilab_graphviz_path");
catch
    unittestPath = get_absolute_file_path("graph_api_plot_output.tst");
    unittestPath  = getshortpathname(unittestPath);
    rootPath = strncpy(unittestPath, length(unittestPath)-length("\tests\unit_tests\") );
end

newaxes();
dotFilePath = fullpath(rootPath + "/examples/coding_callgraph.dot");
// Processes the dot file using graph_api
graph_api("command","dot","data",dotFilePath,"output","plot");

// Get the size of the children from axes
axes = gca();
axesHandleSize = size(axes.children,1);
delete(gca().parent);

// Check if there are equal
flag = assert_checkequal(axesHandleSize,34);

//==============================================================================
