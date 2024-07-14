% 定义温度范围
temperatures = 250:10:350; % 从250 K到350 K，步长为10 K

% 定义压力范围
pressures = 0.8:0.2:1.2; % 从0.8 atm到1.2 atm，步长为0.2 atm

% 初始化x和y的数组
x_values = zeros(length(temperatures), length(pressures));
y_values = zeros(length(temperatures), length(pressures));

% 使用非线性函数计算每个温度和压力对应的x和y值
for j = 1:length(pressures)
	for i = 1:length(temperatures)
		temperature = temperatures(i);
		pressure = pressures(j);
		% 使用非线性函数计算x和y
		x_values(i, j) = log(temperature) * sqrt(pressure); 
		y_values(i, j) = temperature^2 / pressure; 
        [x_values(i, j), y_values(i, j)] = cal_s_h(temperature, pressure);
	end
end

% 绘制等温线
figure;
hold on; % 保持当前图像，以便在同一图像上绘制多条线
for j = 1:length(pressures)
	plot(x_values(:, j), y_values(:, j), 'o-', 'DisplayName', ['P = ' num2str(pressures(j)) ' atm']); % 绘制并标记每条线
end
hold off;
title('等温线图');
xlabel('X轴标签');
ylabel('Y轴标签');
legend show; % 显示图例