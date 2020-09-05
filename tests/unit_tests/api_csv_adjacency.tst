// Copyright (C) 2020 Sysenso Systems Private Limited
//
// Author: Sysenso Systems Private Limited
// Organization: Sysenso Systems Private Limited
// Email: contactus@sysenso.com

//==============================================================================
// Test case to check adjacency_to_csv and csv_to_adjacency function.

// Initial test data
adjData  = [  0.   1.   1.   0.   1.   0.   1.   0.;...
0.   0.   0.   1.   0.   0.   0.   0.;...
0.   0.   0.   0.   0.   0.   0.   0.;...
0.   0.   0.   0.   0.   1.   1.   1.;...
0.   0.   0.   0.   0.   1.   0.   0.;...
0.   0.   0.   0.   0.   0.   0.   0.;...
0.   0.   0.   0.   0.   0.   0.   0.;...
0.   0.   0.   0.   0.   0.   0.   0.];
names  = ["main"  "parse"  "cleanup"  "execute"  "init"  "make_string"  "printf"  "compare"];

// Generate the csv file from the Adjacency Matrix.
adjacency_to_csv(adjData,'adjacencyMatrix.csv',names);

// Generate the Adjacency Matrix from the dot file.
[generatedAdjData,generatedNames] = csv_to_adjacency('adjacencyMatrix.csv');
deletefile('adjacencyMatrix.csv');

// Check if there are any issues.
flag = assert_checkequal(generatedAdjData,adjData);
flag = assert_checkequal(generatedNames,names);

//==============================================================================

