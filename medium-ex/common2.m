% 参数定义
theta_1_range = -pi/9:0.01:4*pi/9;
AB_0_range = 1.2:0.01:2.2;
theta_BOC = pi/9;
weight = 4000;
g = 9.81;
W = weight * g;
OC = 4;

% 定义优化问题
F_min = inf;
optimal_theta_1 = NaN;
optimal_theta_2 = NaN;
optimal_x = NaN;
optimal_y = NaN;

% 遍历所有theta_1和AB_0的组合
for theta_1_value = theta_1_range
    for AB_0_value = AB_0_range
        % 定义目标函数
        objective = @(vars) vars(4); % F

        % 初始猜测
        initial_guess = [1; 1; pi/4; 10000]; % x, y, theta_2, F 

        % 边界约束
        lb = [0.1; 0.1; 0; 0]; % x, y, theta_2, F的下界
        ub = [10; 10; 2*pi; Inf]; % x, y, theta_2, F的上界

        % 约束条件
        nonlincon = @(vars) deal([], [
            2.2^2 - vars(1)^2 - vars(2)^2 - 2 * vars(1) * vars(2) * cos(vars(3) + pi/18);
            1.2^2 - vars(1)^2 - vars(2)^2 + 2 * vars(1) * vars(2) * cos(vars(3));
            W * cos(theta_1_value) * OC - vars(4) * sin(theta_1_value + vars(3) + pi/18) * vars(1)/AB_0_value
        ]);

        % 优化选项
        options = optimoptions('fmincon', 'Display', 'off');

        % 运行优化
        [optimal_vars, F_value] = fmincon(objective, initial_guess, [], [], [], [], lb, ub, nonlincon, options);

        % 检查是否是更优解
        if F_value < F_min
            F_min = F_value;
            optimal_theta_1 = theta_1_value;
            optimal_x = optimal_vars(1);
            optimal_y = optimal_vars(2);
            optimal_theta_2 = optimal_vars(3);
        end
    end
end

% 输出结果
fprintf('F的最小值为: %f\n', F_min);
fprintf('对应的theta_1值为: %f\n', optimal_theta_1);
fprintf('对应的theta_2值为: %f\n', optimal_theta_2);
fprintf('对应的x值为: %f\n', optimal_x);
fprintf('对应的y值为: %f\n', optimal_y);
