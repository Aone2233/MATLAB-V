function [s_0, h_0] = cal_s_h(p, t)
% ������һЩ����
% p_x = 16.53; % MPa P*�Ĵ�С
% T_x = 1386; % T*�Ĵ�С
R = 0.461526; % kJ��kg-1��K-1���峣��

% ��ʼ���ʣ���
s_0 = t .* 0;
h_0 = t .* 0;
ps = p_sat(t); % ��������ѹ
% pai = p ./ 16.53; % ������ѹ��
tao_1 = 1386 ./ t; % �������¶�
% һ���ж�
s = t >= 273.15 & t <= 623.15 & p >= ps & p <= 100; % �ж��Ƿ�������1��
s_0(s) = R .* (tao_1 .* Gibbs_tao_R1(p, t) - Gibbs_R1(p, t));
h_0(s) = R .* t .* tao_1 .* Gibbs_tao_R1(p, t);
% �����ж�
ts = t_sat(p);
t23 = t_B23(p);
tao_2 = 540 ./ t;
n = ((t>= ts & t<=623.15)|(t >= t23 & t >= 623.15) ) & t <= 1073.15 & p<=100;
s_0(n) = R .* (tao_2 .* (Gibbs_tao_0_R2(p, t) + Gibbs_tao_r_R2(p, t))-(Gibbs_0_R2(p, t) + Gibbs_r_R2(p, t)));
h_0(n) = R .* t .* tao_2 .* (Gibbs_tao_0_R2(p, t) + Gibbs_tao_r_R2(p, t));
% �����ж�
p23 = p_B23(t);
k = t >= 623.15 & t < t23 & p >= p23 & p <= 100;
rho = density_R3half(p, t); % �ȼ�����ܶȣ��������ܶȵõ���Ӧ���ʺ���
tao_3 = 647.096 ./ t;
delta = rho./ 322;
s_0(k) = R .* (tao_3 .* Helmz_phi_tao_R3(rho, t) - Helmz_phi_R3(rho, t));
h_0(k) = R .* t .* (tao_3 .* Helmz_phi_tao_R3(rho, t) + delta .* Helmz_phi_delta_R3(rho, t));
end