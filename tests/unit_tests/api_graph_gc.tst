// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

//==============================================================================
// Test case to check graph_gc.sci functions work properly.
expectedMetrics.nodes = 8;
expectedMetrics.edges = 9;
expectedMetrics.ccomps = 1;
expectedMetrics.cluster = 0;
expectedMetrics.graphName = "G";

// Get the dot file path
try
    rootPath = getenv("scilab_graphviz_path");
catch
    unittestPath = get_absolute_file_path("api_graph_gc.tst");
    unittestPath  = getshortpathname(unittestPath);
    rootPath = strncpy(unittestPath, length(unittestPath)-length("\tests\unit_tests\") );
end

dotFilePath = fullpath(rootPath + "/examples/coding_callgraph.dot");
// Generate the graphMetrics for the given dot file
graphMetrics = graph_gc(dotFilePath);

// Check if there are any issues.
flag = assert_checkequal(graphMetrics,expectedMetrics);
//==============================================================================
