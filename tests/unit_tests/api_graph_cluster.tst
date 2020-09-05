// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

//==============================================================================
// Test case to check graph_cluster.sci functions work properly.

// Get the dot file path
try
    rootPath = getenv("scilab_graphviz_path");
catch
    unittestPath = get_absolute_file_path("api_graph_cluster.tst");
    unittestPath  = getshortpathname(unittestPath);
    rootPath = strncpy(unittestPath, length(unittestPath)-length("\tests\unit_tests\") );
end

dotFilePath = fullpath(rootPath + "/examples/coding_callgraph.dot");
// Generate the connected component graphs for the given disconnected_graph.dot file
outputFileName = 'cluster_graph.dot';
generated_graph = graph_cluster(dotFilePath);
graph_cluster(dotFilePath,'outputFile',outputFileName)

// Read the generated graphs from the dot file.
output_graph = mgetl(outputFileName);

// Check if there are any issues.
flag = assert_checkequal(output_graph,generated_graph);

// Delete generated file
deletefile(outputFileName);
//==============================================================================
