// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

//==============================================================================
// Test case to check whether graph_api supports different file formats.

// Get the root path
try
    rootPath = getenv("scilab_graphviz_path");
catch
    unittestPath = get_absolute_file_path("graph_api_file_formats.tst");
    unittestPath  = getshortpathname(unittestPath);
    rootPath = strncpy(unittestPath, length(unittestPath)-length("\tests\unit_tests\") );
end
newaxes();
// Plot a Graph form of dot file using graph_api
dotFilePath = fullpath(rootPath + "/examples/company_management_tree.dot");
try
    graph_api("command","dot","data",dotFilePath,"output","plot");
catch
    delete(gca().parent);
    assert_generror("Error in processing dot file using graph_api");
end

// Plot a Graph form of gv file using graph_api
gvFilePath = fullpath(rootPath + "/examples/coding_callgraph.gv");
try
    graph_api("command","dot","data",gvFilePath,"output","plot");
catch
    delete(gca().parent);
    assert_generror("Error in processing gv file using graph_api");
end

// Plot a Graph form of gxl file using graph_api
gxlFilePath = fullpath(rootPath + "/examples/graph_exchange_language.gxl");
try
    graph_api("command","dot","data",gxlFilePath,"output","plot");
catch
    delete(gca().parent);
    assert_generror("Error in processing gxl file using graph_api");
end

// Plot a Graph form of csv file using graph_api
csvFilePath = fullpath(rootPath + "/examples/csv_sample.csv");
try
    graph_api("command","dot","data",csvFilePath,"output","plot");
catch
    delete(gca().parent);
    assert_generror("Error in processing csv file using graph_api");
end
delete(gca().parent);

//==============================================================================
