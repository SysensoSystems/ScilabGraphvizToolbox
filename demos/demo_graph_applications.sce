mode(0)

function demo_graph_applications()

    msgResponse = messagebox("Demo to show applications of graph drawing.", "Graph Applications", "info", ["Continue" "Stop"], "modal") 

    if msgResponse == 1
        try
            rootPath = getenv("scilab_graphviz_path");
        catch
            demoPath = get_absolute_file_path("demo_graph_applications.sce");
            demoPath = getshortpathname(demoPath);
            rootPath = strncpy(demoPath, length(demoPath)-length("\demos\") );
        end
        newaxes();
        // Using graph_api to show coding_callgraph.dot file
        dotFilePath = fullpath(rootPath + "/examples/coding_callgraph.dot");
        graph_api("command","dot","data",dotFilePath,"output","image");
        messagebox(["Coding Call-Graph","Press OK to continue."], "Graph Applications", "info", "OK", "modal");

        // Using graph_api to show company_management_tree.dot file
        dotFilePath = fullpath(rootPath + "/examples/company_management_tree.dot");
        graph_api("command","dot","data",dotFilePath,"output","image");
        messagebox(["Hierarchy chart - Company Management Team","Press OK to continue."], "Graph Applications", "info", "OK", "modal");

        // Using graph_api to show state_diagram.dot file
        dotFilePath = fullpath(rootPath + "/examples/state_diagram.dot");
        graph_api("command","dot","data",dotFilePath,"output","image");
        messagebox(["State Diagram - Gear Transmission","Press OK to continue."], "Graph Applications", "info", "OK", "modal");

        // Using graph_api to show process_flow.dot file
        dotFilePath = fullpath(rootPath + "/examples/process_flow.dot");
        graph_api("command","dot","data",dotFilePath,"output","image");
        messagebox(["Flowchart graph","Press OK to continue."], "Graph Applications", "info", "OK", "modal");

        close(gca().parent);
    else
        messagebox("Exited the Demo", "User Interruption", "warning", "Done", "modal");
    end
endfunction
// ====================================================================
demo_graph_applications();
clear demo_graph_applications;
// ====================================================================
