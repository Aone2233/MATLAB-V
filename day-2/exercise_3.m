% ʾ������
A = [1, 2, 7; 4, 5, 6; 7, 8, 9];

% ����ֵ 7 ��λ��
[row, col] = find(A == 7); % ��7��λ�ô洢��row��col��

% ��ʾ���
for i = 1:length(row)
    fprintf('ֵ 7 λ�ھ���ĵ� %d �У��� %d �С�\n', row(i), col(i)); % ��ȡrow��col�е�ֵ�����
end

