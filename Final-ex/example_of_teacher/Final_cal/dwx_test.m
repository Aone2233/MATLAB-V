% �����¶ȷ�Χ
temperatures = 250:10:350; % ��250 K��350 K������Ϊ10 K

% ����ѹ����Χ
pressures = 0.8:0.2:1.2; % ��0.8 atm��1.2 atm������Ϊ0.2 atm

% ��ʼ��x��y������
x_values = zeros(length(temperatures), length(pressures));
y_values = zeros(length(temperatures), length(pressures));

% ʹ�÷����Ժ�������ÿ���¶Ⱥ�ѹ����Ӧ��x��yֵ
for j = 1:length(pressures)
	for i = 1:length(temperatures)
		temperature = temperatures(i);
		pressure = pressures(j);
		% ʹ�÷����Ժ�������x��y
		x_values(i, j) = log(temperature) * sqrt(pressure); 
		y_values(i, j) = temperature^2 / pressure; 
        [x_values(i, j), y_values(i, j)] = cal_s_h(temperature, pressure);
	end
end

% ���Ƶ�����
figure;
hold on; % ���ֵ�ǰͼ���Ա���ͬһͼ���ϻ��ƶ�����
for j = 1:length(pressures)
	plot(x_values(:, j), y_values(:, j), 'o-', 'DisplayName', ['P = ' num2str(pressures(j)) ' atm']); % ���Ʋ����ÿ����
end
hold off;
title('������ͼ');
xlabel('X���ǩ');
ylabel('Y���ǩ');
legend show; % ��ʾͼ��