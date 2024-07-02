% 提示用户输入坐标
x1 = input('请输入第一点的 x 坐标: ');
y1 = input('请输入第一点的 y 坐标: ');
x2 = input('请输入第二点的 x 坐标: ');
y2 = input('请输入第二点的 y 坐标: ');
x3 = input('请输入第三点的 x 坐标: ');
y3 = input('请输入第三点的 y 坐标: ');

% 主程序部分
% 定义点的坐标
points = {'第一点', '第二点', '第三点'};
coordinates = {[x1, y1], [x2, y2], [x3, y3]}; % 将坐标存储为cell数组，注意cell数组不支持直接数值运算

% 调用函数计算距离
distance = zeros(1, length(points)); % 初始化距离数组为0
for i = 1:length(points) % 遍历每个点
    x = coordinates{i}(1); % 获取x坐标
    y = coordinates{i}(2); % 获取y坐标
    distance(i) = calculateDistance(x, y); % 计算距离
end

% 找出最大距离及其对应的点
[maxDistance, maxIndex] = max(distance);
maxPoint = points{maxIndex};

% 显示结果
fprintf('最大距离是：%e\n', maxDistance);
fprintf('对应的点是：%s\n', maxPoint);


function distance = calculateDistance(x, y)
    % calculateDistance 计算平面坐标系中点到原点的距离
    %
    % 参数:
    %   x 点的x坐标
    %   y 点的y坐标
    %
    % 返回:
    %   distance - 点到原点之间的距离

    % 计算到原点之间的距离
    distance = sqrt(x^2 + y^2);
end


