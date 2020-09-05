# Name: Scilab Graphviz Toolbox

Name of the external software/library: Grpahviz 
Graphviz (Graph Visualization Software) is an open-source package initiated by AT&T Labs Research for drawing graphs specified in DOT(Graph Description language) files.

## Domain: Graph Drawing
Graph drawing is an area of mathematics and computer science combining methods from geometric graph theory and
information visualization to derive two-dimensional depictions of graphs arising from applications such as 
networking, cartography, linguistics, software engineering, database and web design, machine learning and bioinformatics.
Some of the application areas of the graph drawing, includes
 - Computer science: To represent networks of communication, data organization, computational devices, the flow of computation
 - Linguistics
 - Mathematics:  Algebraic graph theory, group theory, Hasse diagrams - used to represent a finite partially ordered set.
 - Physics and chemistry: To study molecules in chemistry and physics.
 - Social sciences: To study for social network analysis(Sociograms).
 - Biology:  Used in molecular biology and genomics to model and analyse datasets with complex relationships.
 - Programming: To draw flowcharts, drawings in which the nodes represent the steps of an algorithm and the edges represent control flow between steps.
 - Control systems: State diagrams, graphical representations of finite-state machines.
 - Business Information System: Data-flow diagrams, drawings in which the nodes represent the components and the edges represent the movement of information.
 - Bioinformatics: Phylogenetic trees, protein–protein interaction networks, and metabolic pathways.

## Purpose: This is a Scilab toolbox to call graphviz-graph visualization functions. 
Refer the link "https://graphviz.gitlab.io/resources/" to learn more on the use of Grpahviz funcions.
This toolbox helps the Scilab users to do all graph drawing and viewing activities of Grpahviz within Scilab.

## Target Operating System: Windows.
It requires graphviz to be installed on the system. Refer "https://graphviz.org/download/" for download and installation instructions for different operating systems.
We are accessing Graphviz using System/Shell commands. Hence, this toolbox will work in Linux as well without any further code changes.

## Prerequisite - For Windows
Windows Installation: 
- Download the latest version from the link "https://graphviz.gitlab.io/_pages/Download/Download_windows.html"
- Install the Grpahviz with the default settings.
Default Path: Windows
c:\Program Files\Graphviz*\dot.exe or c:\Program Files (x86)\Graphviz*\dot.exe, depending on which version of Windows you are using.
- Set the PATH variable manually to use this application from other program.
    * In Search, search for and then select: System (Control Panel)
    * Click the Advanced system settings link.
    * Click Environment Variables. In the section System Variables, find the PATH environment variable and select it. Click Edit. If the PATH environment variable does not exist, click New.
    * In the Edit System Variable (or New System Variable) window, specify the value of the PATH environment variable. Click OK. Close all remaining windows by clicking OK.
Disclaimer: As noted, this toolbox supposed to work in Linux as well. Please refer installation instructions of Graphviz for the Linux OS. Then try using this toolbox similar to Windows machines. 

## Building External software/library: 
This toolbox invokes Graphviz via System/Shell commands. Hence, these is no need to external softwares/APIs.
Toolbox uses few functions from "Image Processing and Computer Vision Toolbox" for Scilab, when image plotting is used. 
Hence, this becomes an optional to the user.

## Folder Structure
- demos: Demo sample files.
- etc: .start and .quit functions for the toolbox
- examples: Sample graph files
- help: Generated help files
- jar:
- locales:
- macros: Main folder for the toolbox. It includes APIs and GUI functions 
- tests: Test setup to validate the functionality.
- builder.sce
- cleaner.sce
- loader.sce
- unloader.sce
- README: Current file
- DESCRIPTION:

## To build this toolbox
1. Browse this toolbox folder and then type 'exec builder.sce' to run the builder within Scilab.
2. Upon the successful build, run 'exec loader.sce' in the scilab console. The toolbox will be ready to use.

-----------------------------------------------------------------------------------------------------------------
## Toolbox Help
This toolbox consists of APIs and GUI based viewer to use Graphviz functionalities. Refer the corressponding help of each function from the Scilab.

Graph file format:
Graphviz uses .gv/.dot files based on the graph description language. Also, it supports .gxl(Graph eXchange Language) and .gml(Graph Modelling Language) formats.

Graph Layouts:
	* dot - Hierarchical Layout
	* neato - Spring Layout(Minimum Energy)
	* fdp - Spring Layout(Reducing Forces)
	* sfdp - Spring Layout(Multiscale)
	* twopi - Radial Layout
	* circo - Circular Layout
	* patchwork - Squarified treemap
	* osage - Cluster structure

APIs
-----
* dot_to_adjacency: Helps to generate adjacency matrix for the given .dot file(graph description language).
 	
* adjacency_to_dot: Helps to generate .dot file(graph description language) for the given adjacency matrix.
  
* graph_api: Common API to plot adjacency matrix/graph files(.gv, .dot, .gml, .gxl) into Scilab plot. graph_api useful to call the Graphviz layout commands(dot/neato/fdp/sfdp/twopi/circo/patchwork/osage) from Scilab. 

* update_graph_plot: Updates the Scilab plot with the given plot property settings. It is useful to update the Scilab plot which was generated using graph_api.

* csv_to_adjacency: Helps to read adjacency matrix from the given .csv file .

* adjacency_to_csv: Helps to write the adjacency matrix to a .csv file 

* convert_graph_file: Helps to convert graph files between different file formats(.gv, .dot, .gxl, .gml).

* graph_ccomps: Helps to find the connected components in the given .dot file.

* graph_dijkstra: Helps to find the distance of each node from the given source node.

* graph_gc: Helps to find the graph metrics for the given .dot file

* graph_cluster: Helps to find clusters and augment the cluster information for the given .dot file.

* graph_gvpack: Helps to merge and pack two or more .dot file to single .dot file.

GUI Tool/Graph Drawing and Viewing Tool
----------------------------------------
* graph_tool
This is a GUI based utility used to plot graph files(.gv, .dot, .gml, .gxl) or the adjacency matrix. 
It has following features.
 - View the generated graph image file
	* It requires "Image Processing and Computer Vision Toolbox" for Scilab.
	* If it is not installed earlier, install it using the command in Scilab console as -->atomsInstall("IPCV") 
 - Features to edit the graph generated in Scilab axes
 - Different layout algorithms available in Graphviz, that can be used from the GUI.
 - Export/Save into different file formats.
-----------------------------------------------------------------------------------------------------------------
Help and Demos:
----------------
Please refer the help and demo files for more information.
-----------------------------------------------------------------------------------------------------------------
Version: 1.0.0

Author: Hariharan Ravi
	Neelakanda Bharathiraja Urgavalan
	Ajay Krishna Vasanthakumar

Contact: contactus@sysenso.com

Entity: Sysenso Systems Private Limited, India
-----------------------------------------------------------------------------------------------------------------
This work is a part of the Scilab Toolbox Hackathon organised by FOSSEE, IIT Bombay in June-July 2020. (https://fossee.in/ https://scilab.in/).
