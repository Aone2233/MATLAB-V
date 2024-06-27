% 设定常量
weight = 4000; % 重物重量，单位：kg
g = 9.81; % 重力加速度，单位：m/s^2
W = weight * g; % 重物的重力，单位：N

OC = 4; % 固定长度，单位：m
BOC_angle = deg2rad(20); % 固定角度，单位：rad

% 变量范围和初值
ub = [2.2, 2.2, deg2rad(80), deg2rad(80)]; % 上限
x0 = [1.7, 1.7, deg2rad(30), deg2rad(30)]; % 初值
lb = [1.2, 1.2, deg2rad(-20), deg2rad(-20)]; % 下限

% 优化选项
options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');

% 优化求解
[x, fval] = fmincon(@peakLoad, x0, [], [], [], [], lb, ub, [], options);

% 输出结果
OA = x(1);
OB = x(2);
phi2 = rad2deg(x(3));
phi1 = rad2deg(x(4));
peak_load = fval;

% 目标函数定义需要移动到这里
function F = peakLoad(x)
    weight = 4000; % 重定义，确保函数内部可用
    g = 9.81;
    W = weight * g;
    OC = 4;
    BOC_angle = deg2rad(20);

    OA = x(1);
    OB = x(2);
    phi2 = x(3);
    phi1 = x(4);

    % 计算点B的位置
    Bx = OC * cos(phi1 + BOC_angle);
    By = OC * sin(phi1 + BOC_angle);
    
    % 计算点A的位置
    Ax = OA * cos(phi2);
    Ay = OA * sin(phi2);
    
    % 计算AB的长度
    AB = sqrt((Bx - Ax)^2 + (By - Ay)^2);
    
    % 计算液压油缸的载荷
    Fx = W * (Bx / OC);
    Fy = W * (By / OC);
    
    % 液压油缸的总力
    load = sqrt(Fx^2 + Fy^2);
    
    % 返回峰值载荷
    F = max(load);
end