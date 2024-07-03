% 本关考如何实现极坐标的图像显示

theta = 0:0.01:6*pi;
k = 0.5;
r = k*theta;
polarplot(theta, r);
title('r = kθ');
grid on;

% 接下来考验你有关对数尺度的图像显示

x = 0:0.01:10;
y = 10^x;
semilogx(x, y);
title('y = 10^x');
grid on;