% ���ؿ����ʵ�ּ������ͼ����ʾ

theta = 0:0.01:6*pi;
k = 0.5;
r = k*theta;
polarplot(theta, r);
title('r = k��');
grid on;

% �������������йض����߶ȵ�ͼ����ʾ

x = 0:0.01:10;
y = 10^x;
semilogx(x, y);
title('y = 10^x');
grid on;