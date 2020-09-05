mode(0)

function demo_graphapi_output()

    msgResponse = messagebox("Demo to show the different output(image/plot/data) options of graph_api.", "GRAPH_API Output Options", "info", ["Continue" "Stop"], "modal") 

    if msgResponse == 1        
        try
            rootPath = getenv("scilab_graphviz_path");
        catch
            demoPath = get_absolute_file_path("demo_graphapi_output.sce");
            demoPath = getshortpathname(demoPath);
            rootPath = strncpy(demoPath, length(demoPath)-length("\demos\") );
        end
        dotFilePath = fullpath(rootPath + "/examples/coding_callgraph.dot");

        // Using graph_api plot dot file
        graph_api("command","dot","data",dotFilePath);
        messagebox("Showing the Scilab PLOT option. Press OK to continue.", "GRAPH_API Output Options", "info", "OK", "modal");

        // Using graph_api dot file output as an image
        graph_api("command","dot","data",dotFilePath,'output','image');
        messagebox("Showing the results of IMAGE option. Press OK to continue.", "GRAPH_API Output Options", "info", "OK", "modal");

        // Using graph_api to the nodes and edge data for the dot file
        close(gca().parent);
        [settings,graphData] = graph_api("command","dot","data",dotFilePath,'output','data');
        messagebox("Refer the Scilab console for graph data. Press OK to continue.", "GRAPH_API Output Options", "info", "OK", "modal");
        disp('Refer graphData and settings variables which are output of graph_api.');
    else
        messagebox("Exited the Demo", "User Interruption", "warning", "Done", "modal");
    end

endfunction
// ====================================================================
demo_graphapi_output();
clear demo_graphapi_output;
// ====================================================================

