function test()


filename='objects.txt';
objects=getObjectData(filename);
start=[0.58 -3.107];
goal=[-0.03 10.65];
[vertices edges] = visibilityGraph(start, goal, objects);
disp(size(edges));