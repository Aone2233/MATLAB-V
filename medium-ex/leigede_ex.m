[fai1,fai2]=meshgrid(-20:80,0:65);
delta = (cosd(fai2)-cosd(fai2+100));
b = 4.84*cosd(fai2)-1.44*cosd(fai2+100);
x = 0.5*(sqrt((b-3.4)./delta)+sqrt((b+3.4)./delta));
y = 0.5*(sqrt((b+3.4)./delta)-sqrt((b-3.4)./delta));
F = 4000*9.8*4*cosd(fai1).*sqrt(x.^2+y.^2-2*x.*y.*cosd(20+fai1+fai2))./(x.*y.*sind(20+fai1+fai2));
mesh(fai1,fai2,F,'FaceAlpha','0.5');
axis([-20 80 0 65 2.2e+5 2.6e+5]);