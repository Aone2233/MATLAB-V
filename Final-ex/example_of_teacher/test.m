% This program is used to test the speed of a user defined function
% Input the name of user defined function to filename
% It will calculate the function of pressure from p1 to p1, 100 points
% temperature from t1 K to t2 K , 100 points
% the value calculated v will be plotted as a 3-D plot.
clear;
% Input the name of user defined function to filename
filename=input('Input your function name please:','s');
% set the boundary of the calculation
p1 = input('minimum of the first argument:');
p2 = input('maximum of the first argument:');
t1 = input('minimum of the second argument:');
t2 = input('maximum of the second argument:');
% Generate the mesh grid data of pressure and temperature
xlin = linspace(p1,p2,100);
ylin = linspace(t1,t2,100);
[x,y] = meshgrid(xlin,ylin);
% Start to calculate
tic;
v = feval(filename,x,y);
% display the results
disp(['Time used is ' num2str(toc) 's']);
mesh(x,y,v);
xlabel('x');
ylabel('y');
zlabel(filename);