function ydot = zfun(x,p,flag,A,E)
ydot = [p(2);
    A*(0.5*x^2-5-E)*p(1)];
end