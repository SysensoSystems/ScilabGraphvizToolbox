// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

//==============================================================================
// Test case to check graph_dijkstra.sci functions work properly.

// Get the dot file path
try
    rootPath = getenv("scilab_graphviz_path");
catch
    unittestPath = get_absolute_file_path("api_graph_dijkstra.tst");
    unittestPath  = getshortpathname(unittestPath);
    rootPath = strncpy(unittestPath, length(unittestPath)-length("\tests\unit_tests\") );
end

dotFilePath = fullpath(rootPath + "/examples/coding_callgraph.dot");
// Get the distance of each node from the given sourcenode of the dot file.
distance = graph_dijkstra(dotFilePath,'main');

// Check if there are any issues.
flag = assert_checkequal(size(distance.nodeDistance,1),8);
flag = assert_checkequal(distance.maxDistance,3);
//==============================================================================
