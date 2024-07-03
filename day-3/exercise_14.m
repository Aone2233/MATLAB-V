P = 1000000;

ep = 0;

r = @(theta) P./(1-ep .* cos(theta));

theta = 0:0.01:2*pi;

polarplot(theta, r(theta));
hold on;

ep = 0.25;
r = @(theta) P./(1-ep .* cos(theta));
polarplot(theta, r(theta));
hold on;

ep = 0.5;
r = @(theta) P./(1-ep .* cos(theta));
polarplot(theta, r(theta));
hold off;

ax = gca;
title('三种卫星轨迹的极坐标图');
legend('e=0', 'e=0.25', 'e=0.5');
grid on;

% 添加“角度”和“半径”的标签
text(-pi/2, max(r(theta))*1.2, '角度 (radians)', 'HorizontalAlignment', 'center', 'FontSize', 12);
text(pi/4, max(r(theta))/2, '半径 (meters)', 'FontSize', 12);
