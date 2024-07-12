% ����1: �����¶Ⱥ�ѹ��������
t_range = 273.15:1:1073.15;
p_range = 0:1:100;
[T, P] = meshgrid(t_range, p_range);

% ��ʼ��s_0��h_0����
s_0_matrix = zeros(size(T));
h_0_matrix = zeros(size(T));

% ����2: ����s_0��h_0
for i = 1:size(T, 1)
    for j = 1:size(T, 2)
        [s_0, h_0] = cal_s_h(P(i, j), T(i, j));
        s_0_matrix(i, j) = s_0;
        h_0_matrix(i, j) = h_0;
    end
end

% ����3: ������
save('s_h_values.mat', 's_0_matrix', 'h_0_matrix', 'T', 'P');

% ����4: ��������ͼ
figure;
surf(s_0_matrix, h_0_matrix, T); % ʹ��T��Ϊ��ɫӳ��
xlabel('�� s_0 (kJ��kg^{-1}��K^{-1})');
ylabel('�� h_0 (kJ��kg^{-1})');
zlabel('�¶� T (K)');
title('����ͼ');
colorbar; % ��ʾ��ɫ���Ա�ʾ�¶�