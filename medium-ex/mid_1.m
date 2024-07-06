% ��ʼ������
weight = 4000;
g = 9.81;
W = weight * g;
OC = 4;

% ��������
[Theta1, Theta2] = meshgrid(0:65, -20:80);

% ������ű���
syms x y theta_2

% ���巽��
eq1 = 2.2^2 == x^2 + y^2 + 2*x*y*cosd(theta_2 + 10);
eq2 = 1.2^2 == x^2 + y^2 - 2*x*y*cosd(theta_2);

% ʹ�� solve ��ⷽ��
sol = solve([eq1, eq2], [x, y]);

disp(sol.x(1));
disp(sol.y(1));

F = W * cosd(Theta1) * OC * sqrt(sol.x .^ 2 + sol.y .^ 2 - 2 * sol.x * sol.y * cosd(Theta2 + Theta1 + 20)) ./ (sol.x * sol.y * sind(Theta1 + Theta2 + 20));
