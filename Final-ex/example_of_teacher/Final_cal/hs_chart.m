T_range = 273.15:50:1073.15;
P_range = [0.01, 0.002, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 80, 100];

[ P, T ] = meshgrid(P_range, T_range);
s_cal_ot = zeros(length(T_range), length(P_range));
h_cal_ot = zeros(length(T_range), length(P_range));

% ���Ƶ�����ͼ��
for ii = 1:length(T_range)
    for jj = 1:length(P_range)
        [ s_cal_ot(ii,jj), h_cal_ot(ii,jj) ] = cal_s_h(P(ii,jj), T(ii,jj));
    end
    % ���Ƶ�ǰ�¶��µ�����ͼ������
    plot(s_cal_ot(ii,:), h_cal_ot(ii,:), 'color','b','LineWidth',1.5);
    % �����Ͻ�����¶ȱ�ǩ
    text(s_cal_ot(ii,1)+0.77, h_cal_ot(ii,1), sprintf('%.2f', T_range(ii)), 'FontSize', 8, 'Color', 'b', 'HorizontalAlignment', 'left','Units','data');
    axis([0 12.5 0 4500]);
    hold on;
end

% ���Ƶ�ѹ��ͼ��
s_cal_op = zeros(length(T_range), length(P_range));
h_cal_op = zeros(length(T_range), length(P_range));
for jj = 1:length(P_range)
    for ii = 1:length(T_range)
        [ s_cal_op(ii,jj), h_cal_op(ii,jj) ] = cal_s_h(P(ii,jj), T(ii,jj));
    end
    % ���Ƶ�ǰ�¶��µ�����ͼ������
    plot(s_cal_op(:,jj), h_cal_op(:,jj), 'color','r');
    % �����Ͻ����ѹ����ǩ
    text(s_cal_op(end,jj), h_cal_op(end,jj), sprintf('%.2f', P_range(jj)), 'FontSize', 8, 'Color', 'r', 'HorizontalAlignment', 'right','VerticalAlignment', 'bottom');
    hold on;
end

% ���Ƹɶ�ͼ��
x = 0:0.1:1; % �ɶȵ�ȡֵ��Χ
T_s = 273.15:3.5:623.15; % �����¶�
P_s = p_sat(T_s); % ����ѹ�������߾��ǵ������������ߣ�
s_cal_ox = 0 .* T_s;
h_cal_ox = 0 .* T_s;
h_cal_sl = 0 .* T_s;
s_cal_sl = 0 .* T_s;
h_cal_sg = 0 .* T_s;
s_cal_sg = 0 .* T_s;
% �ȼ���õ�����Һ��ͱ����������ʺ���
for kk = 1:length(T_s)
    [s_cal_sl(kk), h_cal_sl(kk)] = cal_s_h(P_s(kk)+1e-10, T_s(kk));
    [s_cal_sg(kk), h_cal_sg(kk)] = cal_s_h(P_s(kk)-1e-10, T_s(kk));
end
% �����չʾ�ɶ�ͼ��ͨ������s��h�ķ�������Բ�ֵ��
for kk = 1:length(x)
    h_cal_ox=h_cal_sl + x(kk) .* (h_cal_sg-h_cal_sl);
    s_cal_ox=s_cal_sl + x(kk) .* (s_cal_sg-s_cal_sl);
    plot(s_cal_ox(2:end),h_cal_ox(2:end),'Color','g','LineWidth',1.5);
    text((s_cal_ox(20)+1) .* 1.25 - 0.4, h_cal_ox(20) - 200 , sprintf('x=%.0f%%', x(kk)*100), 'FontSize', 8, 'Color', 'k', 'HorizontalAlignment', 'right','VerticalAlignment', 'bottom');
    hold on;
end

title('����ͼ');
xlabel('�� s [KJ/(kg��K)]');
ylabel('�� h [KJ/kg]');
hold off;
