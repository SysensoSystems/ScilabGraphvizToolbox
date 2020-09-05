mode(0)

function demo_update_graph_settings()

    msgResponse = messagebox("Demo to show how the plot generated by graph_api can be updated using update_graph_plot.", "Updating Graph Plot", "info", ["Continue" "Stop"], "modal") 

    if msgResponse == 1              
        try
            rootPath = getenv("scilab_graphviz_path");
        catch
            demoPath = get_absolute_file_path("demo_update_graph_settings.sce");
            demoPath  = getshortpathname(demoPath);
            rootPath = strncpy(demoPath, length(demoPath)-length("\demos\") );
        end
        dotFilePath = fullpath(rootPath + "/examples/coding_callgraph.dot");

        // Using graph_api to plot coding_callgraph.dot file
        settings = graph_api("command","dot","data",dotFilePath);
        messagebox(["Graph is plotted with default settings." "Press OK to continue."], "Updating Graph Plot", "info", "OK", "modal");

        // Using update_graph_plot to change node background color of the plotted graph
        settings.backGroundColor = 3;
        update_graph_plot(settings);
        messagebox(["Changed the node background color to green." "Press OK to continue."], "Updating Graph Plot", "info", "OK", "modal");

        // Using update_graph_plot to change node foreground color of the plotted graph
        settings.foreGroundColor = 7;
        update_graph_plot(settings);
        messagebox(["Changed the node foreground color to yellow." "Press OK to continue."], "Updating Graph Plot", "info", "OK", "modal")

        // Using update_graph_plot to change node label color of the plotted graph
        settings.fontColor = 5;
        update_graph_plot(settings);
        messagebox(["Changed the node label color to red." "Press OK to continue."], "Updating Graph Plot", "info", "OK", "modal");

        // Using update_graph_plot to increase node label size of the plotted graph
        settings.fontSize = 3;
        update_graph_plot(settings)
        messagebox(["Next demo to increase the node label size by 2 value." "Press OK to continue."], "Updating Graph Plot", "info", "OK", "modal");

        // Using update_graph_plot to change the node shape of the plotted graph
        settings.nodeShapeValue = "Points";
        update_graph_plot(settings);
        messagebox(["Changed the node shape to Points." "Press OK to continue."], "Updating Graph Plot", "info", "OK", "modal");

        // Using update_graph_plot to change the connector type of the plotted graph
        settings.connectorColor = "blue";
        update_graph_plot(settings)
        messagebox(["Changed the connector color to blue." "Press OK to continue."], "Updating Graph Plot", "info", "OK", "modal");

        // Using update_graph_plot to change the connector type of the plotted graph
        settings.connectorType = "normal";
        update_graph_plot(settings);
        messagebox(["Changed the connector type between the nodes to normal." "Press OK to continue."], "Updating Graph Plot", "info", "OK", "modal");
    else
        messagebox("Exited the Demo", "User Interruption", "warning", "Done", "modal");
    end
endfunction
// ====================================================================
demo_update_graph_settings();
clear demo_update_graph_settings;
// ====================================================================