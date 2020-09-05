// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

function outputFilePath = convert_graph_file(inputFilePath,varargin)
    //   Helps to convert graph files between different file formats(.gv, .dot, .gxl, .gml).
    //
    //   Syntax
    //   convert_graph_file(inputFilePath)
    //   convert_graph_file(inputFilePath,outputFilePath)
    //   outputFilePath = convert_graph_file(inputFilePath)
    //   
    //   Parameters
    //   inputFilePath : Name or Path of the input file that has to be converted.
    //   outputFilePath : Name or Path of the output file that will be generated.
    //
    //   Descriptio
    //   There are different graph file formats(.gv, .dot, .gxl, .gml) available. This API helps to convert between two different file formats.
    //
    //   Examples
    //   // Input file format is ".dot"", then Scilab prompts for the output file path to complete the file conversion.
    //   dotFilePath = uigetfile(["*.dot";],'','Select the DOT file');
    //   convert_graph_file(dotFilePath)
    // 
    //   Examples
    //   //   Input file format is ".gxl"" and the output file format is ".gv". Hence, Scilab uses Graphviz command "gxl2gv" to convert between the given file paths.
    //   gxlFilePath = uigetfile(["*.gxl";],'','Select the GXL file');
    //   gvFilePath = uiputfile(["*.gv";],'','Select the .gv file path');
    //   outputFilePath = convert_graph_file(gxlFilePath,gvFilePath)
    // 

    // Input validations
    if nargin < 1 || nargin > 2
        error("Wrong number of input arguments. Please check the function syntax.");
    end    
    if nargin == 1
        outputFilePath = "";
    elseif nargin == 2
        outputFilePath = varargin(1);
    end
    if isempty(outputFilePath)
        outputFilePath = uiputfile(["*.dot";"*.gv";"*.gml";"*.gxl"],pwd(),"Choose a file to save");
        if isempty(outputFilePath)
            return;
        end
    end

    // Do the file apporpriate file conversion based on the file extensions.
    inExt = fileext(inputFilePath);
    outExt = fileext(outputFilePath);
    if (~strcmp(inExt,'.gxl','i') && ~strcmp(outExt,'.gv','i')) || ~strcmp(inExt,'.gxl','i') && ~strcmp(outExt,'.dot','i')
        baseCommand  = strcat(['gxl2gv -d -o',outputFilePath,' ',inputFilePath]);
        [out,errorValue] = unix_g(baseCommand);
        if errorValue
            error('Graphviz failure. Please check the inputs.'); 
        end
    elseif (~strcmp(inExt,'.gml','i') && ~strcmp(outExt,'.gv','i')) || (~strcmp(inExt,'.gml','i') && ~strcmp(outExt,'.dot','i'))
        baseCommand  = strcat(['gml2gv -o',outputFilePath,' ',inputFilePath]);
        [out,errorValue] = unix_g(baseCommand);
        if errorValue
            error('Graphviz failure. Please check the inputs.'); 
        end
    elseif (~strcmp(inExt,'.gv','i') && ~strcmp(outExt,'.gxl','i')) || (~strcmp(inExt,'.dot','i') && ~strcmp(outExt,'.gxl','i'))
        baseCommand  = strcat(['gv2gxl -g -o',outputFilePath,' ',inputFilePath]);
        [out,errorValue] = unix_g(baseCommand);
        if errorValue
            error('Graphviz failure. Please check the inputs.'); 
        end
    elseif (~strcmp(inExt,'.gv','i') && ~strcmp(outExt,'.gml','i')) || (~strcmp(inExt,'.dot','i') && ~strcmp(outExt,'.gml','i'))
        baseCommand  = strcat(['gv2gml -o',outputFilePath,' ',inputFilePath]);
        [out,errorValue] = unix_g(baseCommand);
        if errorValue
            error('Graphviz failure. Please check the inputs.'); 
        end
    elseif (~strcmp(inExt,'.gml','i') && ~strcmp(outExt,'.gxl','i')) 
        [path, fname, extension] = fileparts(inputFilePath);
        tempFilePath = strcat([path, fname, '.gv']);
        baseCommand  = strcat(['gml2gv -o',tempFilePath,' ',inputFilePath]);
        [out,errorValue] = unix_g(baseCommand);
        if errorValue
            error('Graphviz failure. Please check the inputs.'); 
        end
        baseCommand  = strcat(['gv2gxl -g -o',outputFilePath,' ',tempFilePath]);
        [out,errorValue] = unix_g(baseCommand);
        deletefile(tempFilePath);
        if errorValue
            error('Graphviz failure. Please check the inputs.'); 
        end     
    elseif (~strcmp(inExt,'.gxl','i') && ~strcmp(outExt,'.gml','i')) 
        [path, fname, extension] = fileparts(inputFilePath);
        tempFilePath = strcat([path, fname, '.gv']);
        baseCommand  = strcat(['gxl2gv -d -o',tempFilePath,' ',inputFilePath]);
        [out,errorValue] = unix_g(baseCommand);
        if errorValue
            error('Graphviz failure. Please check the inputs.'); 
        end
        baseCommand  = strcat(['gv2gml -o',outputFilePath,' ',tempFilePath]);
        [out,errorValue] = unix_g(baseCommand);
        deletefile(tempFilePath);
        if errorValue
            error('Graphviz failure. Please check the inputs.'); 
        end   
    elseif (~strcmp(inExt,'.gv','i') && ~strcmp(outExt,'.dot','i')) || (~strcmp(inExt,'.dot','i') && ~strcmp(outExt,'.gv','i'))
        copyfile(inputFilePath, outputFilePath);

    else
        error("Unsupported graph file formats for conversion");
    end

endfunction
