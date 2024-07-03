theta = input('请输入角度（度为单位）：');
cos_theta = cosd(theta);

if abs(cos_theta) < 1e-20
    disp('错误：cos(θ) 的值太接近于 0');
else
    tan_theta = tand(theta);
    fprintf('tan(%.2f) = %.5f\n', theta, tan_theta);
end
