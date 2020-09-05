// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

//==============================================================================
// Test case to check graph_api, "image" output action works properly.

// Initial test data
load imageData;

// Get the dot file path
try
    rootPath = getenv("scilab_graphviz_path");
catch
    unittestPath = get_absolute_file_path("graph_api_image_output.tst");
    unittestPath  = getshortpathname(unittestPath);
    rootPath = strncpy(unittestPath, length(unittestPath)-length("\tests\unit_tests\") );
end

newaxes();
dotFilePath = fullpath(rootPath + "/examples/coding_callgraph.dot");
// Processes the dot file using graph_api
graph_api("command","dot","data",dotFilePath,"output","image");

// Get the image data from axes
axes = gca();
axesData = axes.children.data;
delete(gca().parent);

// Check if there are equal
flag = assert_checkequal(axesData,data);

//==============================================================================
