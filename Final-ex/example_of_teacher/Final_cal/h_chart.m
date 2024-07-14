
P_range = 0:1:100;
T_range = 273.15:8:1073.15;
[P,T] = meshgrid(P_range,T_range); % 生成网格点坐标矩阵
% 计算焓和熵
s_cal = 0 .* T;
h_cal = 0 .* T;
for ii = 1:101
    for jj = 1:101
        [s_cal(ii,jj),h_cal(ii,jj)] = cal_s_h(P(ii,jj),T(ii,jj));
    end
end

mesh(P, T, h_cal); % 绘制焓熵图
colorbar; % 添加颜色条
xlabel('压强'); % x轴标签
ylabel('温度'); % y轴标签
title('焓和压强及温度的关系'); % 图标题
axis([0 100 273.15 1073.15 0 5000]);
