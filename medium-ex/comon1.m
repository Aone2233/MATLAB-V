function comon1()
    % ��ʼ�²�ֵ
    initial_guess = [pi/4, 0, 1.7];  % ������theta_2, theta_1, AB_0�ĳ�ʼֵ

    % �������½�
    lb = [0, -pi/9, 1.2];
    ub = [pi/2, 4*pi/9, 2.2];

    % ����fmincon�����Ż�
    options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
    [optimal_params, F_min] = fmincon(@objectiveFunction, initial_guess, [], [], [], [], lb, ub, @nonlincon, options);

    % ��ʾ���
    theta_2_opt = optimal_params(1);
    theta_1_opt = optimal_params(2);
    AB_0_opt = optimal_params(3);

    fprintf('����theta_2: %.4f\n', theta_2_opt);
    fprintf('����theta_1: %.4f\n', theta_1_opt);
    fprintf('����AB_0: %.4f\n', AB_0_opt);
    fprintf('��СF: %.4f\n', F_min);
end

function F = objectiveFunction(params)
    theta_2 = params(1);
    theta_1 = params(2);
    AB_0 = params(3);
    
    weight = 4000;
    g = 9.81;
    W = weight * g;
    
    % �ⷽ�̵õ�x��y
    options = optimoptions('fsolve', 'Display', 'none');
    eqns = @(vars) [2.2^2 - vars(1)^2 - vars(2)^2 - 2 * vars(1) * vars(2) * cos(theta_2 + pi/18), ...
                    1.2^2 - vars(1)^2 - vars(2)^2 + 2 * vars(1) * vars(2) * cos(theta_2)];
    initial_guess = [1, 1];  % ��ʼ�²�ֵ
    [sol, ~, exitflag] = fsolve(eqns, initial_guess, options);
    
    if exitflag <= 0
        F = Inf; % �������û�н⣬�򷵻������
        return;
    end
    
    x = sol(1);
    y = sol(2);
    
    if x <= 0 || y <= 0
        F = Inf; % ���û�������⣬�򷵻������
        return;
    end
    
    % ����F
    OC = 1.0; % ����OCΪ�����������Ը��������޸�
    F = W * cos(theta_1) * OC - W * sin(theta_1 + theta_2 + pi/18) * x / AB_0;
end

function [c, ceq] = nonlincon(~)
    % �޷�����Լ������
    c = [];
    ceq = [];  % ����е�ʽԼ�������������ﶨ��
end
