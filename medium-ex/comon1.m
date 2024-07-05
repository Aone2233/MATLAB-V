function comon1()
    % 初始猜测值
    initial_guess = [pi/4, 0, 1.7];  % 这里是theta_2, theta_1, AB_0的初始值

    % 参数上下界
    lb = [0, -pi/9, 1.2];
    ub = [pi/2, 4*pi/9, 2.2];

    % 调用fmincon进行优化
    options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
    [optimal_params, F_min] = fmincon(@objectiveFunction, initial_guess, [], [], [], [], lb, ub, @nonlincon, options);

    % 显示结果
    theta_2_opt = optimal_params(1);
    theta_1_opt = optimal_params(2);
    AB_0_opt = optimal_params(3);

    fprintf('最优theta_2: %.4f\n', theta_2_opt);
    fprintf('最优theta_1: %.4f\n', theta_1_opt);
    fprintf('最优AB_0: %.4f\n', AB_0_opt);
    fprintf('最小F: %.4f\n', F_min);
end

function F = objectiveFunction(params)
    theta_2 = params(1);
    theta_1 = params(2);
    AB_0 = params(3);
    
    weight = 4000;
    g = 9.81;
    W = weight * g;
    
    % 解方程得到x和y
    options = optimoptions('fsolve', 'Display', 'none');
    eqns = @(vars) [2.2^2 - vars(1)^2 - vars(2)^2 - 2 * vars(1) * vars(2) * cos(theta_2 + pi/18), ...
                    1.2^2 - vars(1)^2 - vars(2)^2 + 2 * vars(1) * vars(2) * cos(theta_2)];
    initial_guess = [1, 1];  % 初始猜测值
    [sol, ~, exitflag] = fsolve(eqns, initial_guess, options);
    
    if exitflag <= 0
        F = Inf; % 如果方程没有解，则返回无穷大
        return;
    end
    
    x = sol(1);
    y = sol(2);
    
    if x <= 0 || y <= 0
        F = Inf; % 如果没有正数解，则返回无穷大
        return;
    end
    
    % 计算F
    OC = 1.0; % 假设OC为常数或您可以根据需求修改
    F = W * cos(theta_1) * OC - W * sin(theta_1 + theta_2 + pi/18) * x / AB_0;
end

function [c, ceq] = nonlincon(~)
    % 无非线性约束条件
    c = [];
    ceq = [];  % 如果有等式约束条件，在这里定义
end
