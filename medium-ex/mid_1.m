% 初始化参数
theta_2_range = 0:pi / 90:pi / 2; % 0 到 90 度的范围
theta_1_range = -pi / 9:0.01:4 * pi / 9; % theta_1 的范围
% AB_0_range = 1.2:0.01:2.2; % AB_0 的范围
weight = 4000;
g = 9.81;
W = weight * g;

min_F = Inf; % 初始化最小F，将其设置为无穷大
optimal_params = []; % 保存最优参数

% 求解方程组并计算F，注意这里的OA = x，OB = y
for theta_2 = theta_2_range
    % 定义方程组，通过余弦定理求解出x和y
    eqns = @(vars) [2.2 ^ 2 - vars(1) ^ 2 - vars(2) ^ 2 - 2 * vars(1) * vars(2) * cos(theta_2 + pi / 18), ...
                        1.2 ^ 2 - vars(1) ^ 2 - vars(2) ^ 2 + 2 * vars(1) * vars(2) * cos(theta_2)];

    % 初始猜测值
    initial_guess = [1, 1]; % 你可以根据需要调整初始猜测值

    % 使用 fsolve 求解方程
    options = optimoptions('fsolve', 'Display', 'none'); % 采用的优化方法是 fsolve，不显示迭代过程
    [sol, fval, exitflag] = fsolve(eqns, initial_guess, options); % 求解方程组

    % 检查求解是否成功
    if exitflag > 0 && all(fval < 1e-6) % 判断方程是否近似为零
        x = sol(1);
        y = sol(2);

        if x > 0 && y > 0
            % 遍历 theta_1 的范围计算 F
            for theta_1 = theta_1_range

                % 计算AB和F
                OC = 4.0;
                AB_0 = sqrt(x ^ 2 + y ^ 2 - 2 * x * y * cos(theta_2 + theta_1 + pi / 9)); % 余弦定理
                F = W * cos(theta_1) * OC * AB_0 / (sin(theta_1 + theta_2 + pi / 18) * x * y);

                % 保证F为正值
                if F > 0 && F < min_F
                    min_F = F;
                    optimal_params = [theta_2, theta_1, AB_0, x, y];
                end

            end

        end

    end

end

% 显示最小F的结果
if ~isempty(optimal_params)
    theta_2_opt = optimal_params(1);
    theta_1_opt = optimal_params(2);
    AB_0_opt = optimal_params(3);
    x_opt = optimal_params(4);
    y_opt = optimal_params(5);

    fprintf('最优theta_2: %.4f\n', theta_2_opt);
    fprintf('最优theta_1: %.4f\n', theta_1_opt);
    fprintf('最优AB_0: %.4f\n', AB_0_opt);
    fprintf('最优x: %.4f\n', x_opt);
    fprintf('最优y: %.4f\n', y_opt);
    fprintf('最小F: %.4f\n', min_F);
else
    fprintf('未找到合适的解\n');
end
