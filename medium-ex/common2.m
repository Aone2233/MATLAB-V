% ��������
theta_1_range = -pi/9:0.01:4*pi/9;
AB_0_range = 1.2:0.01:2.2;
theta_BOC = pi/9;
weight = 4000;
g = 9.81;
W = weight * g;
OC = 4;

% �����Ż�����
F_min = inf;
optimal_theta_1 = NaN;
optimal_theta_2 = NaN;
optimal_x = NaN;
optimal_y = NaN;

% ��������theta_1��AB_0�����
for theta_1_value = theta_1_range
    for AB_0_value = AB_0_range
        % ����Ŀ�꺯��
        objective = @(vars) vars(4); % F

        % ��ʼ�²�
        initial_guess = [1; 1; pi/4; 10000]; % x, y, theta_2, F 

        % �߽�Լ��
        lb = [0.1; 0.1; 0; 0]; % x, y, theta_2, F���½�
        ub = [10; 10; 2*pi; Inf]; % x, y, theta_2, F���Ͻ�

        % Լ������
        nonlincon = @(vars) deal([], [
            2.2^2 - vars(1)^2 - vars(2)^2 - 2 * vars(1) * vars(2) * cos(vars(3) + pi/18);
            1.2^2 - vars(1)^2 - vars(2)^2 + 2 * vars(1) * vars(2) * cos(vars(3));
            W * cos(theta_1_value) * OC - vars(4) * sin(theta_1_value + vars(3) + pi/18) * vars(1)/AB_0_value
        ]);

        % �Ż�ѡ��
        options = optimoptions('fmincon', 'Display', 'off');

        % �����Ż�
        [optimal_vars, F_value] = fmincon(objective, initial_guess, [], [], [], [], lb, ub, nonlincon, options);

        % ����Ƿ��Ǹ��Ž�
        if F_value < F_min
            F_min = F_value;
            optimal_theta_1 = theta_1_value;
            optimal_x = optimal_vars(1);
            optimal_y = optimal_vars(2);
            optimal_theta_2 = optimal_vars(3);
        end
    end
end

% ������
fprintf('F����СֵΪ: %f\n', F_min);
fprintf('��Ӧ��theta_1ֵΪ: %f\n', optimal_theta_1);
fprintf('��Ӧ��theta_2ֵΪ: %f\n', optimal_theta_2);
fprintf('��Ӧ��xֵΪ: %f\n', optimal_x);
fprintf('��Ӧ��yֵΪ: %f\n', optimal_y);
