% 初始化参数
weight = 4000;
g = 9.81;
W = weight * g;
OC = 4;

% 生成网格
[Theta1, Theta2] = meshgrid(0:65, -20:80);

% 定义符号变量
syms x y theta_2

% 定义方程
eq1 = 2.2^2 == x^2 + y^2 + 2*x*y*cosd(theta_2 + 10);
eq2 = 1.2^2 == x^2 + y^2 - 2*x*y*cosd(theta_2);

% 使用 solve 求解方程
sol = solve([eq1, eq2], [x, y]);

disp(sol.x(1));
disp(sol.y(1));

F = W * cosd(Theta1) * OC * sqrt(sol.x .^ 2 + sol.y .^ 2 - 2 * sol.x * sol.y * cosd(Theta2 + Theta1 + 20)) ./ (sol.x * sol.y * sind(Theta1 + Theta2 + 20));
