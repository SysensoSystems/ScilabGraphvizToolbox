mode(0)

function demo_graphapi_addon()
    msgResponse = messagebox("Demo to show the different addons(tred/unflatten) options for graph_api.", "GRAPH_API Addons Options", "info", ["Continue" "Stop"], "modal") 

    if msgResponse == 1
        try
            rootPath = getenv("scilab_graphviz_path");
        catch
            demoPath = get_absolute_file_path("demo_graphapi_addon.sce");
            demoPath = getshortpathname(demoPath);
            rootPath = strncpy(demoPath, length(demoPath)-length("\demos\") );
        end
        newaxes();
        // Using graph_api to process path_graph.dot file
        dotFilePath = fullpath(rootPath + "/examples/path_graph.dot");  
        graph_api("command","dot","data",dotFilePath,"output","image");
        messagebox(["Processed DOT file without Addons","Press OK to continue."], "Graph File Formats", "info", "OK", "modal");

        // Using graph_api to process path_graph.dot file
        dotFilePath = fullpath(rootPath + "/examples/path_graph.dot");  
        graph_api("command","dot","data",dotFilePath,"output","image","addons",{"tred"});
        messagebox(["Processed DOT file with ''tred'' Addons","Press OK to continue."], "Graph File Formats", "info", "OK", "modal");

        // Using graph_api to process path_graph.dot file
        dotFilePath = fullpath(rootPath + "/examples/path_graph.dot");  
        graph_api("command","dot","data",dotFilePath,"output","image","addons",{"unflatten"});
        messagebox(["Processed DOT file with ''unflatten'' Addons","Press OK to continue."], "Graph File Formats", "info", "OK", "modal");
        
        // Using graph_api to process path_graph.dot file
        dotFilePath = fullpath(rootPath + "/examples/path_graph.dot");  
        graph_api("command","dot","data",dotFilePath,"output","image","addons",{"tred","unflatten"});
        messagebox(["Processed DOT file with both(tred/unflatten) Addons","Press OK to continue."], "Graph File Formats", "info", "OK", "modal");
        
        close(gca().parent);
    else
        messagebox("Exited the Demo", "User Interruption", "warning", "Done", "modal");
    end
endfunction
// ====================================================================
demo_graphapi_addon();
clear demo_graphapi_addon;
// ====================================================================
