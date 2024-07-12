% 步骤1: 生成温度和压力的网格
t_range = 273.15:1:1073.15;
p_range = 0:1:100;
[T, P] = meshgrid(t_range, p_range);

% 初始化s_0和h_0矩阵
s_0_matrix = zeros(size(T));
h_0_matrix = zeros(size(T));

% 步骤2: 计算s_0和h_0
for i = 1:size(T, 1)
    for j = 1:size(T, 2)
        [s_0, h_0] = cal_s_h(P(i, j), T(i, j));
        s_0_matrix(i, j) = s_0;
        h_0_matrix(i, j) = h_0;
    end
end

% 步骤3: 保存结果
save('s_h_values.mat', 's_0_matrix', 'h_0_matrix', 'T', 'P');

% 步骤4: 绘制焓熵图
figure;
surf(s_0_matrix, h_0_matrix, T); % 使用T作为颜色映射
xlabel('熵 s_0 (kJ·kg^{-1}·K^{-1})');
ylabel('焓 h_0 (kJ·kg^{-1})');
zlabel('温度 T (K)');
title('焓熵图');
colorbar; % 显示颜色条以表示温度