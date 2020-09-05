// This file is released under the 3-clause BSD license. See COPYING-BSD.

function buildmacros()
    macros_path = get_absolute_file_path("buildmacros.sce");
    buildmacros_subfolder(TOOLBOX_NAME, macros_path);
endfunction

function buildmacros_subfolder(TOOLBOX_NAME,dirPath)
    // Custom function to manage .bin generation for the functions in the subfolders
    // and also updates the lib(XML) file with subfolder details.

    // Build the files in the macros folder.
    tbx_build_macros(TOOLBOX_NAME, dirPath);
    mainXMLData = xmlRead(dirPath+'lib');    
    fileData = mainXMLData.root.children;

    // Process for every sub-directory
    dirList = dir(dirPath);
    for ind = 1:length(dirList(5))
        if dirList(5)(ind)
            subPath = dirPath + dirList(2)(ind) + filesep();
            // Build the files in the subfolder.
            tbx_build_macros(TOOLBOX_NAME, subPath);
            xmlData = xmlRead(subPath+'lib');    
            for ii = 1:xmlData.root.children.size;
                // Update the file path.
                xmlData.root.children(ii).attributes.file = ".\" + dirList(2)(ind) + filesep() + xmlData.root.children(ii).attributes.file;
                // Append it to the main file records.
                xmlAppend(mainXMLData.root, xmlData.root.children(ii))
            end
            // Delete the lib file generated in teh subfolder.
            deletefile(subPath+'lib');
        end
    end
    // Write the updated XML records.
    xmlWrite(mainXMLData);
endfunction
buildmacros();
clear buildmacros; // remove buildmacros on stack
