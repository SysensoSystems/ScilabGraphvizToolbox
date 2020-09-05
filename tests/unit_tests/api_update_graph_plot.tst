// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

//==============================================================================
// Test case to check update_graph_plot functions work properly.

// Get the dot file path
try
    rootPath = getenv("scilab_graphviz_path");
catch
    unittestPath = get_absolute_file_path("api_update_graph_plot.tst");
    unittestPath  = getshortpathname(unittestPath);
    rootPath = strncpy(unittestPath, length(unittestPath)-length("\tests\unit_tests\") );
end

newaxes();
dotFilePath = fullpath(rootPath + "/examples/coding_callgraph.dot");
// Processes the dot file using graph_api and get the settings variable as return argument
settings = graph_api("command","dot","data",dotFilePath,"output","plot");

// Changing the Node background color and font color 
settings.backGroundColor = 3;
settings.fontColor = 5;

// Update the plot using the update_graph_plot function
try 
    update_graph_plot(settings);
    delete(gca().parent);
catch
    assert_generror("Error using update_graph_plot - Graph not updated");
end
delete(gca().parent);

//==============================================================================
