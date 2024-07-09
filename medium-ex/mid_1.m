% ��ʼ������
theta_1 = -20:1:80;
weight = 4000;
g = 9.81;
W = weight * g;
OC = 4;

% ������ű�������x��y���������⹤��
syms x y theta_2;

% ���巽��
eq_1 = 2.2^2 == x^2 + y^2 + 2*x*y*sind(theta_2 + 10);
eq_2 = 1.2^2 == x^2 + y^2 - 2*x*y*cosd(theta_2);

% ʹ�� solve ��ⷽ��
sol = solve([eq_1, eq_2], [x, y]);

theta_2_values = 0:0.65:65;  % theta_2��ȡֵ��Χ����ǰ�ڵĲ���֮����65��֮��������

% ʹ�� subs ��ֱ�Ӵ��� theta_2 ��ֵ
OA_values = subs(sol.x, theta_2, theta_2_values);

% �����ű��ʽת��Ϊ��ֵ
OA_values_numeric = double(OA_values);

% ��ȡ��һ�У��õ� OA_1
OA_1 = OA_values_numeric(1,:);

% OB �ļ���ͬ��
OB_values = subs(sol.y, theta_2, theta_2_values);
OB_values_numeric = double(OB_values);
OB_1 = OB_values_numeric(1,:);

% ȷ�� theta_1 �� theta_2_values �ĳ����ǳ���
len_theta_1 = length(theta_1);
len_theta_2_values = length(theta_2_values);

% �ȶ�F���г�ʼ��
F = zeros(len_theta_1, len_theta_2_values);

% ѭ��������õ���theta_1��theta_2Ϊ�Ա�����F����ֵ����
parfor yy=1:len_theta_2_values  % ʹ�� theta_2_values �ĳ���
    for xx=1:len_theta_1
        % ֱ��ʹ�� theta_2_values(yy) ��� theta_2(yy)��ȷ������ֵ
        theta_2_val = theta_2_values(yy);
        F(xx, yy) = OC * W * cosd(theta_1(xx)) * sqrt(OA_1(yy)^2 + OB_1(yy)^2 - 2 * OA_1(yy) * OB_1(yy) * cosd(theta_1(xx) + theta_2_val + 20)) / (OA_1(yy) * OB_1(yy) * sind(theta_1(xx) + theta_2_val + 20));
    end
end

% ��ͼ����ʾtheta_1��theta_2��F�Ĺ�ϵ
mesh(theta_1,theta_2_values,F);
axis([-20 80 0 65 2.0e+5 2.5e+5]);

% ��ͼ����ʾtheta_1��theta_2��F�Ĺ�ϵ
mesh(theta_1,theta_2_values,F);
axis([-20 80 0 65 2.0e+5 2.5e+5]);

% ����ֵ��Сֵ
Fmin = min(max(F));
[F_x, F_y] = find(F == Fmin);
theta_1_V = theta_1(F_x);
theta_2_V = theta_2_values(F_y);
OA_1_V = OA_1(F_y);
OB_1_V = OB_1(F_y);

% �����
fprintf('��һ�ʴ𰸣�\n��ֵ������С��ʱ��OAΪ%6.4f m\nOBΪ%6.4f m\n��2Ϊ%6.2f��\n', OA_1_V, OB_1_V, theta_2_V);
fprintf('�ڶ��ʴ𰸣�\n��ֵ��СΪ%6.2f N\n��ʱ��1Ϊ%6.2f��\n', Fmin, theta_1_V);