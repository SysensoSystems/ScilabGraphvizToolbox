mode(0)

function demo_graph_file_formats()
    msgResponse = messagebox("Demo to show the graph_api usage with different file formats.", "Graph File Formats", "info", ["Continue" "Stop"], "modal") 

    if msgResponse == 1
        try
            rootPath = getenv("scilab_graphviz_path");
        catch
            demoPath = get_absolute_file_path("demo_graph_file_formats.sce");
            demoPath = getshortpathname(demoPath);
            rootPath = strncpy(demoPath, length(demoPath)-length("\demos\") );
        end
        newaxes();
        // Using graph_api to process coding_callgraph.dot file
        dotFilePath = fullpath(rootPath + "/examples/coding_callgraph.dot");  
        graph_api("command","dot","data",dotFilePath,"output","image");
        messagebox(["Processed DOT file ","Press OK to continue."], "Graph File Formats", "info", "OK", "modal");

        // Using graph_api to process coding_callgraph.gv file
        gvFilePath = fullpath(rootPath + "/examples/coding_callgraph.gv");
        graph_api("command","dot","data",gvFilePath,"output","image");
        messagebox(["Processed GV file ","Press OK to continue."], "Graph File Formats", "info", "OK", "modal");

        // Using graph_api to process graph_exchange_language.gxl file
        gxlFilePath = fullpath(rootPath + "/examples/graph_exchange_language.gxl");
        graph_api("command","dot","data",gxlFilePath,"output","image");
        messagebox(["Processed GXL file ","Press OK to continue."], "Graph File Formats", "info", "OK", "modal");
        
        // Using graph_api to process comma_separated_values.csv file
        csvFilePath = fullpath(rootPath + "/examples/csv_sample.csv");
        graph_api("command","dot","data",csvFilePath,"output","image");
        messagebox(["Processed CSV file ","Press OK to continue."], "Graph File Formats", "info", "OK", "modal");
        
        close(gca().parent);
    else
        messagebox("Exited the Demo", "User Interruption", "warning", "Done", "modal");
    end
endfunction
// ====================================================================
demo_graph_file_formats();
clear demo_graph_file_formats;
// ====================================================================
