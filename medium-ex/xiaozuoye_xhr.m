%a is the length of OA
%b is the length of OB
%fan1 = -20~80  z=AB=1.2~2.2
%OC=4.0
clear;

syms x y fan2
eq1= x.^2+y.^2-1.2.^2-2.*x.*y.*cos(fan2)==0;
eq2= x.^2+y.^2-2.2.^2-2.*x.*y.*cos(fan2+5*pi/9)==0;
%余弦定理列出两个方程
SOS=solve([eq1,eq2],[x,y]);

fan2=0:0.65:65;
fan2=fan2.*pi./180;
fan1=-20:80;
fan1=fan1.*pi./180;
G=4000.*9.81;
OC=4;

OA = eval (SOS.x);
OA1 = OA(1,:);
OA2 = OA(2,:);

OB = eval (SOS.y);
OB1 = OB(1,:);
OB2 = OB(2,:);

for jj=1:101
    for ii=1:101
AB1(ii,jj)=sqrt(OA1(jj).^2+OB1(jj).^2-2.*OA1(jj).*OB1(jj).*cos(fan1(ii)+fan2(jj)+pi/9));
F(ii,jj)=OC.* G.* cos(fan1(ii)).*AB1(ii,jj)./(OA1(jj).*OB1(jj).*sin(fan1(ii)+fan2(jj)+pi/9));
    end
end

Fmin=min(max(F));
[Fminx, Fminy]=find(F==min(max(F)));
fan1best=fan1(Fminx).*180./pi;
fan2best=fan2(Fminy).*180./pi;
AB1best=AB1(Fminx, Fminy);
OA1best=OA1(Fminx);
OB1best=OB1(Fminx);
fprintf('峰值最小为%6.2f N\n',Fmin);
fprintf('最优OA为%6.2f m\n',OA1best);
fprintf('最优OB为%6.2f m\n',OB1best);
fprintf('最优φ2为%6.2f°\n',fan2best);
fprintf('此时φ1为%6.2f°\n',fan1best);
