t = -2:0.01:2;
x = cos(t/pi);
y = 2 * sin(t/ (2 * pi));
% �������Ӧ���ȴ���굥���������굥�������������ϵ�һ��������
% �ͻ�����ظı��������ߵ���ɫ���ú��� waitforbuttonpress �ȴ���굥��������ÿһ�ε���
% �����ͼ���ú��� gco �жϵ����Ķ��󣬲��� Type �����жϵ����Ķ����Ƿ�Ϊ���ߡ�

plot(x, y, 'r');
while 1
    waitforbuttonpress;
    h = gco;
    if strcmp(get(h, 'Type'), 'line')
        % ���������ɫ
        randomColor = rand(1,3);
        set(h, 'Color', randomColor);
    end
end

