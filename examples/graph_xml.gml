graph [
  version 2
  directed 1
  node [
    id 0
    name "main"
  ]
  node [
    id 1
    name "parse"
  ]
  node [
    id 2
    name "execute"
  ]
  node [
    id 3
    name "init"
  ]
  node [
    id 4
    name "cleanup"
  ]
  node [
    id 5
    name "make_string"
  ]
  node [
    id 6
    name "printf"
  ]
  node [
    id 7
    name "compare"
  ]
  edge [
    id 1
    source 0
    target 1
  ]
  edge [
    id 3
    source 0
    target 3
  ]
  edge [
    id 4
    source 0
    target 4
  ]
  edge [
    id 8
    source 0
    target 6
  ]
  edge [
    id 2
    source 1
    target 2
  ]
  edge [
    id 5
    source 2
    target 5
  ]
  edge [
    id 6
    source 2
    target 6
  ]
  edge [
    id 9
    source 2
    target 7
  ]
  edge [
    id 7
    source 3
    target 5
  ]
]
