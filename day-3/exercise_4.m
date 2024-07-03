x = input("请输出x的值: ");
y = input("请输出y的值: ");

if x >= 0 && y >= 0
    f = x + y;
    disp(f);

elseif x >= 0 && y < 0
    f = x - y.^2;
    disp(f);

elseif x < 0 && y >= 0
    f = x.^2 + y;
    disp(f);


else
    f = x.^2 - y.^2;
    disp(f);

end
