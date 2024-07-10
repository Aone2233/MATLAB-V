t = -2:0.01:2;
x = cos(t/pi);
y = 2 * sin(t/ (2 * pi));
% 这个程序应当等待鼠标单击，如果鼠标单击在两条曲线上的一条，程序
% 就会随机地改变这条曲线的颜色。用函数 waitforbuttonpress 等待鼠标单击，并在每一次单击
% 后更新图象。用函数 gco 判断单击的对象，并用 Type 属性判断单击的对象是否为曲线。

plot(x, y, 'r');
while 1
    waitforbuttonpress;
    h = gco;
    if strcmp(get(h, 'Type'), 'line')
        % 生成随机颜色
        randomColor = rand(1,3);
        set(h, 'Color', randomColor);
    end
end

