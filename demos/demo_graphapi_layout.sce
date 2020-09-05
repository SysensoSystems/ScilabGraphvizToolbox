mode(0)

function demo_graphapi_layout()

    msgResponse = messagebox("Demo to show different Graphviz layout options of graph_api.", "Graphviz Layouts", "info", ["Continue" "Stop"], "modal") 

    if msgResponse == 1 
        try
            rootPath = getenv("scilab_graphviz_path");
        catch
            demoPath = get_absolute_file_path("demo_graphapi_layout.sce");
            demoPath = getshortpathname(demoPath);
            rootPath = strncpy(demoPath, length(demoPath)-length("\demos\") );
        end
        dotFilePath = fullpath(rootPath + "/examples/coding_callgraph.dot");

        // Using graph_api to show dot - Hierarchical Layout
        graph_api("command","dot","data",dotFilePath,'output','image');
        messagebox("dot - Hierarchical Layout. Press OK to continue.", "Graphviz Layouts", "info", "OK", "modal");

        // Using graph_api to show neato - Spring Layout(Minimum Energy)
        graph_api("command","neato","data",dotFilePath,'output','image');
        messagebox("neato - Spring Layout(Minimum Energy). Press OK to continue.", "Graphviz Layouts", "info", "OK", "modal"); 

        // Using graph_api to show fdp - Spring Layout(Reducing Forces)
        graph_api("command","fdp","data",dotFilePath,'output','image');
        messagebox("fdp - Spring Layout(Reducing Forces). Press OK to continue.", "Graphviz Layouts", "info", "OK", "modal");

        // Using graph_api to show sfdp - Spring Layout(Multiscale)
        graph_api("command","sfdp","data",dotFilePath,'output','image');
        messagebox("sfdp - Spring Layout(Multiscale). Press OK to continue.", "Graphviz Layouts", "info", "OK", "modal");

        // Using graph_api to show twopi - Radial Layout
        graph_api("command","twopi","data",dotFilePath,'output','image');
        messagebox("twopi - Radial Layout. Press OK to continue.", "Graphviz Layouts", "info", "OK", "modal");

        // Using graph_api to show circo - Circular Layout
        graph_api("command","circo","data",dotFilePath,'output','image');
        messagebox("Press OK to continue.", " ", "info", "OK", "modal") 

        // Using graph_api to show patchwork - Squarified treemap
        graph_api("command","patchwork","data",dotFilePath,'output','image');
        messagebox("patchwork - Squarified treemap. Press OK to continue.", "Graphviz Layouts", "info", "OK", "modal") 

        // Using graph_api to show osage - Cluster structure
        graph_api("command","osage","data",dotFilePath,'output','image');
        messagebox("osage - Cluster structure. Press OK to continue.", "Graphviz Layouts", "info", "OK", "modal");

        close(gca().parent);
    else
        messagebox("Exited the Demo", "User Interruption", "warning", "Done", "modal");
    end

endfunction
// ====================================================================
demo_graphapi_layout();
clear demo_graphapi_layout;
// ====================================================================

