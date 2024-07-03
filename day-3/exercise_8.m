theta = -pi/2:0.01:pi/2;

sincx = @(x) sin(x)./x; % sinc(x) = sin(x)/x
G = sincx(4*theta); % G = |sin(4θ)/(4θ)|
G(theta == 0) = 1; % 0/0 = 1
G = abs(G); % 取绝对值

plot(theta, G);
title('G = |sin(4θ)/(4θ)|');
xlabel('执物面的反射角度θ');
ylabel('微波天线的接受增益G');
grid on;