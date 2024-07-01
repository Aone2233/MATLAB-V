% �趨����
weight = 4000; % ������������λ��kg
g = 9.81; % �������ٶȣ���λ��m/s^2
W = weight * g; % �������������λ��N

OC = 4; % �̶����ȣ���λ��m
BOC_angle = deg2rad(20); % �̶��Ƕȣ���λ��rad

% ������Χ�ͳ�ֵ
ub = [2.2, 2.2, deg2rad(80), deg2rad(80)]; % ����
x0 = [1.7, 1.7, deg2rad(30), deg2rad(30)]; % ��ֵ
lb = [1.2, 1.2, deg2rad(-20), deg2rad(-20)]; % ����

% �Ż�ѡ��
options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');

% �Ż����
[x, fval] = fmincon(@peakLoad, x0, [], [], [], [], lb, ub, [], options);

% ������
OA = x(1);
OB = x(2);
phi2 = rad2deg(x(3));
phi1 = rad2deg(x(4));
peak_load = fval;

% Ŀ�꺯��������Ҫ�ƶ�������
function F = peakLoad(x)
    weight = 4000; % �ض��壬ȷ�������ڲ�����
    g = 9.81;
    W = weight * g;
    OC = 4;
    BOC_angle = deg2rad(20);

    OA = x(1);
    OB = x(2);
    phi2 = x(3);
    phi1 = x(4);

    % �����B��λ��
    Bx = OC * cos(phi1 + BOC_angle);
    By = OC * sin(phi1 + BOC_angle);
    
    % �����A��λ��
    Ax = OA * cos(phi2);
    Ay = OA * sin(phi2);
    
    % ����AB�ĳ���
    AB = sqrt((Bx - Ax)^2 + (By - Ay)^2);
    
    % ����Һѹ�͸׵��غ�
    Fx = W * (Bx / OC);
    Fy = W * (By / OC);
    
    % Һѹ�͸׵�����
    load = sqrt(Fx^2 + Fy^2);
    
    % ���ط�ֵ�غ�
    F = max(load);
end