msgResponse = messagebox("Demo to show how adjacency matrix can be used with graph_api. Please follow the Scilab console.", "GRAPH_API - Adjacency Matrix", "info", ["Continue" "Stop"], "modal") 

if msgResponse == 1 
    try
        rootPath = getenv("scilab_graphviz_path");
    catch
        demoPath = get_absolute_file_path("demo_graphapi_adjacencymatrix.sce");
        demoPath = getshortpathname(demoPath);
        rootPath = strncpy(demoPath, length(demoPath)-length("\demos\") );
    end
else
    messagebox("Exited the Demo", "User Interruption", "warning", "Done", "modal");
    return;
end
//-----------------------------------------------------------------------------
mode(1)
dotFilePath = fullpath(rootPath + "/examples/adjacencyMatrixData.dat");
disp(dotFilePath);

// Load adjacency matrix
halt("Loading the adjacency matrix variable in the workspace. Press Enter key to continue.");
load(dotFilePath)

// Using graph_api plot adjacency matrix 
halt("Next step: Graph drawing for the adjacency matrix. Press Enter key to continue.");;
newaxes();
graph_api("command","dot","data",adjacencyMatrix);

// Using graph_api adjacency matrix output as an image
halt("Next step: Image form of adjacency matrix. Press Enter key to continue.");;
graph_api("command","dot","data",adjacencyMatrix,'output','image');

halt("Press Enter key to complete the demo.");;
close(gca().parent);
disp("Completed the Demo.");;
//-----------------------------------------------------------------------------
