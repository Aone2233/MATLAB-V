t = 0:0.01:2 * pi;
x = 10 .* cos(t);
y = 10 .* sin(t);
% 修改图象的默认颜色为桔黄色，默认线宽为 3.0point
plot(x, y, 'color', [1, 0.5, 0], 'linewidth', 3.0);