theta = -pi/2:0.01:pi/2;

sincx = @(x) sin(x)./x; % sinc(x) = sin(x)/x
G = sincx(4*theta); % G = |sin(4��)/(4��)|
G(theta == 0) = 1; % 0/0 = 1
G = abs(G); % ȡ����ֵ

plot(theta, G);
title('G = |sin(4��)/(4��)|');
xlabel('ִ����ķ���ǶȦ�');
ylabel('΢�����ߵĽ�������G');
grid on;