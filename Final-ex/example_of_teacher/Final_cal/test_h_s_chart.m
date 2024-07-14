T_range = 273.15:50:1073.15;
P_range = [0.01, 0.002, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 80, 100];

[ P, T ] = meshgrid(P_range, T_range);
[s_cal_ot, h_cal_ot] = arrayfun(@cal_s_h, P, T);

% 绘制等温线图像
hold on;
for ii = 1:length(T_range)
    plot(s_cal_ot(ii,:), h_cal_ot(ii,:), 'color', 'b', 'LineWidth', 1.5);
    text(s_cal_ot(ii,1)+0.77, h_cal_ot(ii,1), sprintf('%.2f', T_range(ii)), 'FontSize', 8, 'Color', 'b', 'HorizontalAlignment', 'left');
end
axis([0 12.5 0 4500]);

% 绘制等压线图像
for jj = 1:length(P_range)
    plot(s_cal_ot(:,jj), h_cal_ot(:,jj), 'color', 'r');
    text(s_cal_ot(end,jj), h_cal_ot(end,jj), sprintf('%.2f', P_range(jj)), 'FontSize', 8, 'Color', 'r', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom');
end

% 绘制干度图像
x = 0:0.1:1; % 干度的取值范围
T_s = 273.15:3.5:623.15; % 饱和温度
P_s = p_sat(T_s); % 饱和压力
[s_cal_sl, h_cal_sl] = arrayfun(@(T, P) cal_s_h(P + 1e-10, T), T_s, P_s);
[s_cal_sg, h_cal_sg] = arrayfun(@(T, P) cal_s_h(P - 1e-10, T), T_s, P_s);

for kk = 1:length(x)
    h_cal_ox = h_cal_sl + x(kk) .* (h_cal_sg - h_cal_sl);
    s_cal_ox = s_cal_sl + x(kk) .* (s_cal_sg - s_cal_sl);
    plot(s_cal_ox(2:end), h_cal_ox(2:end), 'Color', 'g', 'LineWidth', 1.5);
    text((s_cal_ox(20)+1) * 1.25 - 0.4, h_cal_ox(20) - 200 , sprintf('x=%.0f%%', x(kk)*100), 'FontSize', 8, 'Color', 'k', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom');
end

title('焓熵图');
xlabel('熵 s [KJ/(kg・K)]');
ylabel('焓 h [KJ/kg]');
hold off;
