function [s_0, h_0] = final_test(p, t)
% ������һЩ����
% p_x = 16.53; % MPa P*�Ĵ�С
T_x = 1386; % T*�Ĵ�С
R = 8.314; % J/(mol*K)���峣��

% ��ʼ��s����
s_0 = t * 0;
h_0 = t * 0;
ps = p_sat(t); % ��������ѹ
% pai = p / p_x; % ������ѹ��
tao = T_x ./ t; % �������¶�
for s = t >= 273.15 & t <= 623.15 & p >= ps & p <= 100 % �ж��Ƿ�������1��
    for i = 1:34
        s_0(s) = R .* (tao .* Gibbs_tao_R1(p, t) - Gibbs_R1(p, t));
        h_0(s) = R .* t .* tao .* Gibbs_tao_R1(p, t);
    end
end


