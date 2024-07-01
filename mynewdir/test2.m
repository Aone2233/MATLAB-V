% create an input array from -2*pi to 2*pi
t = -2*pi:pi/10:2*pi;
% calculate|sin(t)|
x=abs(sin(t));
%plot result
plot(t,x);