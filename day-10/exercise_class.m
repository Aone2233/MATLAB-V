% syms x a b;
% f = x*(1+a/x)^x*sin(b/x);
% L = limit(f,x,inf)

x = -0.01:0.00003:0.01;
y = -0.01:0.0003:0.01;
z0 = 1;
lamda = 600e-9;
a = 2*pi/lamda;
[X,Y] = meshgrid(x,y);
R1 = sqrt((X+0.0001).^2 + z0^2);
R2 = sqrt((X-0.0001).^2 + z0^2);
I1 = 1./R1;
I2 = 1./R2;
I = I1 + I2 + 2. *sqrt(I1.*I2).*cos(a.*(R2-R1));
figure;
hold on
colormap(gray);
view(0,90); % 0度~90度视角
mesh(X,Y,I);
xlabel('x');
ylabel('y');
zlabel('I');
title('双缝干涉图案');
hold off
