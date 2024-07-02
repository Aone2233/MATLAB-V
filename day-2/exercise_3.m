% 示例矩阵
A = [1, 2, 7; 4, 5, 6; 7, 8, 9];

% 查找值 7 的位置
[row, col] = find(A == 7); % 将7的位置存储在row和col中

% 显示结果
for i = 1:length(row)
    fprintf('值 7 位于矩阵的第 %d 行，第 %d 列。\n', row(i), col(i)); % 读取row和col中的值并输出
end

