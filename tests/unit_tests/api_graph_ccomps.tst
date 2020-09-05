// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

//==============================================================================
// Test case to check graph_ccomps.sci functions work properly.

first_graph = sprintf("digraph G_cc_0 {\n\tA -> B;\n\tB -> D;\n\tB -> E;\n\tB -> F;\n}");
second_graph = sprintf("digraph G_cc_1 {\n\tC -> H;\n\tH -> I;\n\tH -> J;\n}");

// Get the dot file path
try
    rootPath = getenv("scilab_graphviz_path");
catch
    unittestPath = get_absolute_file_path("api_graph_ccomps.tst");
    unittestPath  = getshortpathname(unittestPath);
    rootPath = strncpy(unittestPath, length(unittestPath)-length("\tests\unit_tests\") );
end

dotFilePath = fullpath(rootPath + "/examples/disconnected_graph.dot");
// Generate the connected component graphs for the given disconnected_graph.dot file
outputFileName = 'ccomps_graph';
graph_ccomps(dotFilePath,'outputFile',strcat([outputFileName,'.dot']))

// Read the generated graphs from the dot file.
first_generated_graph = mgetl(strcat([outputFileName,'.dot']));
second_generated_graph = mgetl(strcat([outputFileName,'_1.dot']));

// Check if there are any issues.
flag = assert_checkequal(first_generated_graph,first_graph);
flag = assert_checkequal(second_generated_graph,second_graph);

// Delete generated file
deletefile(strcat([outputFileName,'.dot']));
deletefile(strcat([outputFileName,'_1.dot']));
//==============================================================================
