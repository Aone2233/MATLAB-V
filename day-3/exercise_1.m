theta = input('������Ƕȣ���Ϊ��λ����');
cos_theta = cosd(theta);

if abs(cos_theta) < 1e-20
    disp('����cos(��) ��ֵ̫�ӽ��� 0');
else
    tan_theta = tand(theta);
    fprintf('tan(%.2f) = %.5f\n', theta, tan_theta);
end
