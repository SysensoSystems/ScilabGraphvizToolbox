mode(0)

function demo_graph_tool_functionality()

    msgResponse = messagebox("Demo for the Scilab Graph Tool.", "Scilab Graph Tool", "info", ["Continue" "Stop"], "modal") 

    if msgResponse == 1 
        try
            rootPath = getenv("scilab_graphviz_path");
        catch
            demoPath = get_absolute_file_path("demo_graph_tool_functionality.sce");
            demoPath = getshortpathname(demoPath);
            rootPath = strncpy(demoPath, length(demoPath)-length("\demos\") );
        end

        // Using graph_tool to plot coding_callgraph.dot file
        dotFilePath = fullpath(rootPath + "/examples/coding_callgraph.dot");
        handles = graph_tool();
        set(handles.browseEdit,'String',dotFilePath);
        callback = get(handles.dotButton,'Callback');
        gcbo = handles.dotButton;
        execstr(callback);
        messagebox("Shwoing function call graph in a plot. Press OK to continue.", "Scilab Graph Tool", "info", "OK", "modal");
        close(handles.figH);

        // Using graph_tool to show image form of coding_callgraph.dot file
        handles = graph_tool();
        set(handles.browseEdit,'String',dotFilePath);
        set(handles.outputTypePopUpButton,'Value',2);
        callback = get(handles.dotButton,'Callback');
        gcbo = handles.dotButton;
        execstr(callback);
        messagebox("Shwoing function call graph in an image. Press OK to continue.", "Scilab Graph Tool", "info", "OK", "modal"); 
        close(handles.figH);

        // Using graph_tool to plot process_flow.dot file
        dotFilePath = fullpath(rootPath + "/examples/process_flow.dot")
        handles = graph_tool();
        set(handles.browseEdit,'String',dotFilePath);
        set(handles.outputTypePopUpButton,'Value',1);
        callback = get(handles.dotButton,'Callback');
        gcbo = handles.dotButton;
        execstr(callback);
        messagebox("Shwoing proces flow diagram in a plot. Press OK to continue.", "Scilab Graph Tool", "info", "OK", "modal");
        close(handles.figH);

        // Using graph_tool to show image form of process_flow.dot file
        handles = graph_tool();
        set(handles.browseEdit,'String',dotFilePath);
        set(handles.outputTypePopUpButton,'Value',2);
        callback = get(handles.dotButton,'Callback');
        gcbo = handles.dotButton;
        execstr(callback);
        messagebox("Shwoing proces flow diagram in an image. Press OK to continue.", "Scilab Graph Tool", "info", "OK", "modal");
        close(handles.figH);

        // Using graph_tool to plot state_diagram.dot file
        dotFilePath = fullpath(rootPath + "/examples/state_diagram.dot")
        handles = graph_tool();
        set(handles.browseEdit,'String',dotFilePath);
        set(handles.outputTypePopUpButton,'Value',1);
        callback = get(handles.dotButton,'Callback');
        gcbo = handles.dotButton;
        execstr(callback);
        messagebox("Shwoing state diagram in a plot. Press OK to continue.", " ", "info", "OK", "modal");
        close(handles.figH);

        // Using graph_tool to show image form of state_diagram.dot file
        handles = graph_tool();
        set(handles.browseEdit,'String',dotFilePath);
        set(handles.outputTypePopUpButton,'Value',2);
        callback = get(handles.dotButton,'Callback');
        gcbo = handles.dotButton;
        execstr(callback);
        messagebox("Shwoing state diagram in an image. Press OK to continue.", "Scilab Graph Tool", "info", "OK", "modal");
        close(handles.figH);

    else
        messagebox("Exited the Demo", "User Interruption", "warning", "Done", "modal");
    end

endfunction
// ====================================================================
demo_graph_tool_functionality();
clear demo_graph_tool_functionality;
// ====================================================================

