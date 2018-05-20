#! /usr/bin/env python
import sys
edges = set()
for line in open(sys.argv[1]):
    if not line.startswith('L'): continue
    line = line.split()
    a,b = map(int,tuple((line[1],line[3])))
    edges.add((a,b))

for a,b in edges:
    if (b,a) not in edges:
        print(a,b)
