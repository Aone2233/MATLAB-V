function r = density_R3(p,t,r0)
r1 = p*0+r0;
r = r1;
r2 = r1+1;
p1 = r1; p2 = r1; df = r1; err = r1; 
s = (err>1.0e-4);
while(s)
    r2(s) = r1(s)+1;
% calculate f1 and f2
    p1(s) = press_R3(r1(s),t(s))-p(s);
    p2(s) = press_R3(r2(s),t(s))-p(s);
% use (f1-f2)/(x1-x2) to calculate the differential term of df(p,t)
    df(s)= 1e6*(p1(s) - p2(s))./(r1(s) - r2(s));
    r1(s) = r1(s)-1e6*p1(s)./df(s);
% calculate the errors
    err = abs(1e6*p1(s)./df(s));
    s = err>1.0e-4;
end
r = r1;
s1 = (r > 800 | r < 0);
r(s1) = 0;

function p = press_R3(rho,t)
p = rho.*0.461526e3.*t.*rho./322.*Helmz_phi_R3(rho,t)./1e6;