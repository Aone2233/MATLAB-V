function p = press_R3(rho,t)
p = rho.*0.461526e3.*t.*rho./322.*Helmz_phi_R3(rho,t)./1e6;