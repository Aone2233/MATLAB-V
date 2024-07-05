% ��ʼ������
theta_2_range = 0:pi / 90:pi / 2; % 0 �� 90 �ȵķ�Χ
theta_1_range = -pi / 9:0.01:4 * pi / 9; % theta_1 �ķ�Χ
% AB_0_range = 1.2:0.01:2.2; % AB_0 �ķ�Χ
weight = 4000;
g = 9.81;
W = weight * g;

min_F = Inf; % ��ʼ����СF����������Ϊ�����
optimal_params = []; % �������Ų���

% ��ⷽ���鲢����F��ע�������OA = x��OB = y
for theta_2 = theta_2_range
    % ���巽���飬ͨ�����Ҷ�������x��y
    eqns = @(vars) [2.2 ^ 2 - vars(1) ^ 2 - vars(2) ^ 2 - 2 * vars(1) * vars(2) * cos(theta_2 + pi / 18), ...
                        1.2 ^ 2 - vars(1) ^ 2 - vars(2) ^ 2 + 2 * vars(1) * vars(2) * cos(theta_2)];

    % ��ʼ�²�ֵ
    initial_guess = [1, 1]; % ����Ը�����Ҫ������ʼ�²�ֵ

    % ʹ�� fsolve ��ⷽ��
    options = optimoptions('fsolve', 'Display', 'none'); % ���õ��Ż������� fsolve������ʾ��������
    [sol, fval, exitflag] = fsolve(eqns, initial_guess, options); % ��ⷽ����

    % �������Ƿ�ɹ�
    if exitflag > 0 && all(fval < 1e-6) % �жϷ����Ƿ����Ϊ��
        x = sol(1);
        y = sol(2);

        if x > 0 && y > 0
            % ���� theta_1 �ķ�Χ���� F
            for theta_1 = theta_1_range

                % ����AB��F
                OC = 4.0;
                AB_0 = sqrt(x ^ 2 + y ^ 2 - 2 * x * y * cos(theta_2 + theta_1 + pi / 9)); % ���Ҷ���
                F = W * cos(theta_1) * OC * AB_0 / (sin(theta_1 + theta_2 + pi / 18) * x * y);

                % ��֤FΪ��ֵ
                if F > 0 && F < min_F
                    min_F = F;
                    optimal_params = [theta_2, theta_1, AB_0, x, y];
                end

            end

        end

    end

end

% ��ʾ��СF�Ľ��
if ~isempty(optimal_params)
    theta_2_opt = optimal_params(1);
    theta_1_opt = optimal_params(2);
    AB_0_opt = optimal_params(3);
    x_opt = optimal_params(4);
    y_opt = optimal_params(5);

    fprintf('����theta_2: %.4f\n', theta_2_opt);
    fprintf('����theta_1: %.4f\n', theta_1_opt);
    fprintf('����AB_0: %.4f\n', AB_0_opt);
    fprintf('����x: %.4f\n', x_opt);
    fprintf('����y: %.4f\n', y_opt);
    fprintf('��СF: %.4f\n', min_F);
else
    fprintf('δ�ҵ����ʵĽ�\n');
end
