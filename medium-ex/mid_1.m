% 初始化参数
theta_1 = -20:1:80;
weight = 4000;
g = 9.81;
W = weight * g;
OC = 4;

% 定义符号变量
syms x y theta_2;

% 定义方程
eq_1 = 2.2^2 == x^2 + y^2 + 2*x*y*sind(theta_2 + 10);
eq_2 = 1.2^2 == x^2 + y^2 - 2*x*y*cosd(theta_2);

% 使用 solve 求解方程
sol = solve([eq_1, eq_2], [x, y]);

theta_2 = 0:0.65:65;  % theta_2的取值范围经过前期的测试之后在65度之后都是虚数

OA = eval (sol.x);
OA_1 = OA(1,:);

OB = eval (sol.y);
OB_1 = OB(1,:);

% 先对F进行初始化
F = zeros(101, 101);

% 循环求解计算得到以theta_1和theta_2为自变量的F的数值矩阵
for yy=1:101
    for xx=1:101
        F(xx, yy)=OC.* W.* cosd(theta_1(xx)).*sqrt(OA_1(yy).^2+OB_1(yy).^2-2.*OA_1(yy).*OB_1(yy).*cosd(theta_1(xx)+theta_2(yy)+20))./(OA_1(yy).*OB_1(yy).*sind(theta_1(xx)+theta_2(yy)+20));
    end
end

% 画图，显示theta_1和theta_2与F的关系
mesh(theta_1,theta_2,F);
axis([-20 80 0 65 2.2e+5 2.6e+5]);

% 求解峰值最小值
Fmin = min(max(F));
[F_x, F_y] = find(F == Fmin);
theta_1_V = theta_1(F_x);
theta_2_V = theta_2(F_y);
OA_1_V = OA_1(F_y);
OB_1_V = OB_1(F_y);

% 输出答案
fprintf('第一问答案：\n峰值负载最小的时候，OA为%6.4f m\nOB为%6.4f m\nφ2为%6.2f°\n', OA_1_V, OB_1_V, theta_2_V);
fprintf('第二问答案：\n峰值最小为%6.2f N\n此时φ1为%6.2f°\n', Fmin, theta_1_V);