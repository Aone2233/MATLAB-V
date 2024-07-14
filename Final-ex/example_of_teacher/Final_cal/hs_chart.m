T_range = 273.15:50:1073.15;
P_range = [0.01, 0.002, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 80, 100];

[ P, T ] = meshgrid(P_range, T_range);
s_cal_ot = zeros(length(T_range), length(P_range));
h_cal_ot = zeros(length(T_range), length(P_range));

% 绘制等温线图像
for ii = 1:length(T_range)
    for jj = 1:length(P_range)
        [ s_cal_ot(ii,jj), h_cal_ot(ii,jj) ] = cal_s_h(P(ii,jj), T(ii,jj));
    end
    % 绘制当前温度下的焓熵图等温线
    plot(s_cal_ot(ii,:), h_cal_ot(ii,:), 'color','b','LineWidth',1.5);
    % 在右上角添加温度标签
    text(s_cal_ot(ii,1)+0.77, h_cal_ot(ii,1), sprintf('%.2f', T_range(ii)), 'FontSize', 8, 'Color', 'b', 'HorizontalAlignment', 'left','Units','data');
    axis([0 12.5 0 4500]);
    hold on;
end

% 绘制等压线图像
s_cal_op = zeros(length(T_range), length(P_range));
h_cal_op = zeros(length(T_range), length(P_range));
for jj = 1:length(P_range)
    for ii = 1:length(T_range)
        [ s_cal_op(ii,jj), h_cal_op(ii,jj) ] = cal_s_h(P(ii,jj), T(ii,jj));
    end
    % 绘制当前温度下的焓熵图等温线
    plot(s_cal_op(:,jj), h_cal_op(:,jj), 'color','r');
    % 在右上角添加压力标签
    text(s_cal_op(end,jj), h_cal_op(end,jj), sprintf('%.2f', P_range(jj)), 'FontSize', 8, 'Color', 'r', 'HorizontalAlignment', 'right','VerticalAlignment', 'bottom');
    hold on;
end

% 绘制干度图像
x = 0:0.1:1; % 干度的取值范围
T_s = 273.15:3.5:623.15; % 饱和温度
P_s = p_sat(T_s); % 饱和压力，二者就是第四区（饱和线）
s_cal_ox = 0 .* T_s;
h_cal_ox = 0 .* T_s;
h_cal_sl = 0 .* T_s;
s_cal_sl = 0 .* T_s;
h_cal_sg = 0 .* T_s;
s_cal_sg = 0 .* T_s;
% 先计算得到饱和液体和饱和蒸汽的焓和熵
for kk = 1:length(T_s)
    [s_cal_sl(kk), h_cal_sl(kk)] = cal_s_h(P_s(kk)+1e-10, T_s(kk));
    [s_cal_sg(kk), h_cal_sg(kk)] = cal_s_h(P_s(kk)-1e-10, T_s(kk));
end
% 计算和展示干度图像（通过对于s和h的反解和线性插值）
for kk = 1:length(x)
    h_cal_ox=h_cal_sl + x(kk) .* (h_cal_sg-h_cal_sl);
    s_cal_ox=s_cal_sl + x(kk) .* (s_cal_sg-s_cal_sl);
    plot(s_cal_ox(2:end),h_cal_ox(2:end),'Color','g','LineWidth',1.5);
    text((s_cal_ox(20)+1) .* 1.25 - 0.4, h_cal_ox(20) - 200 , sprintf('x=%.0f%%', x(kk)*100), 'FontSize', 8, 'Color', 'k', 'HorizontalAlignment', 'right','VerticalAlignment', 'bottom');
    hold on;
end

title('焓熵图');
xlabel('熵 s [KJ/(kg·K)]');
ylabel('焓 h [KJ/kg]');
hold off;
