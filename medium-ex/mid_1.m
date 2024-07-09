% 初始化参数
theta_1 = -20:1:80;
weight = 4000;
g = 9.81;
W = weight * g;
OC = 4;

% 定义符号变量进行x和y方程组的求解工作
syms x y theta_2;

% 定义方程
eq_1 = 2.2^2 == x^2 + y^2 + 2*x*y*sind(theta_2 + 10);
eq_2 = 1.2^2 == x^2 + y^2 - 2*x*y*cosd(theta_2);

% 使用 solve 求解方程
sol = solve([eq_1, eq_2], [x, y]);

theta_2_values = 0:0.65:65;  % theta_2的取值范围经过前期的测试之后在65度之后都是虚数

% 使用 subs ，直接代入 theta_2 的值
OA_values = subs(sol.x, theta_2, theta_2_values);

% 将符号表达式转换为数值
OA_values_numeric = double(OA_values);

% 提取第一行，得到 OA_1
OA_1 = OA_values_numeric(1,:);

% OB 的计算同理
OB_values = subs(sol.y, theta_2, theta_2_values);
OB_values_numeric = double(OB_values);
OB_1 = OB_values_numeric(1,:);

% 确保 theta_1 和 theta_2_values 的长度是常数
len_theta_1 = length(theta_1);
len_theta_2_values = length(theta_2_values);

% 先对F进行初始化
F = zeros(len_theta_1, len_theta_2_values);

% 循环求解计算得到以theta_1和theta_2为自变量的F的数值矩阵
parfor yy=1:len_theta_2_values  % 使用 theta_2_values 的长度
    for xx=1:len_theta_1
        % 直接使用 theta_2_values(yy) 替代 theta_2(yy)，确保是数值
        theta_2_val = theta_2_values(yy);
        F(xx, yy) = OC * W * cosd(theta_1(xx)) * sqrt(OA_1(yy)^2 + OB_1(yy)^2 - 2 * OA_1(yy) * OB_1(yy) * cosd(theta_1(xx) + theta_2_val + 20)) / (OA_1(yy) * OB_1(yy) * sind(theta_1(xx) + theta_2_val + 20));
    end
end

% 画图，显示theta_1和theta_2与F的关系
mesh(theta_1,theta_2_values,F);
axis([-20 80 0 65 2.0e+5 2.5e+5]);

% 画图，显示theta_1和theta_2与F的关系
mesh(theta_1,theta_2_values,F);
axis([-20 80 0 65 2.0e+5 2.5e+5]);

% 求解峰值最小值
Fmin = min(max(F));
[F_x, F_y] = find(F == Fmin);
theta_1_V = theta_1(F_x);
theta_2_V = theta_2_values(F_y);
OA_1_V = OA_1(F_y);
OB_1_V = OB_1(F_y);

% 输出答案
fprintf('第一问答案：\n峰值负载最小的时候，OA为%6.4f m\nOB为%6.4f m\nφ2为%6.2f°\n', OA_1_V, OB_1_V, theta_2_V);
fprintf('第二问答案：\n峰值最小为%6.2f N\n此时φ1为%6.2f°\n', Fmin, theta_1_V);