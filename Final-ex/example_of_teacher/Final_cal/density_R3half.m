function r = density_R3half(p,t)
r1 = p*0+1;
r2 = r1+900;
r = r1;
p1 = r1; p2 = r1; err = r1; r12 = r1; p12 = r1; e = err;

while(~(err<1.0e-4))
    s = (err>1.0e-4);
    p1(s) = press_R3(r1(s),t(s))-p(s);
    p2(s) = press_R3(r2(s),t(s))-p(s);
    r12(s) = (r1(s)+r2(s))./2;
    p12(s) =press_R3(r12(s),t(s))-p(s);
    r1(p12<0) = r12(p12<0);
    r2(p12>=0) = r12(p12>=0);
    err = abs(r1(s) - r2(s))./r1(s);
end
r = r1;

function p = press_R3(rho,t)
p = rho.*0.461526e3.*t.*rho./322.*Helmz_phi_R3(rho,t)./1e6;