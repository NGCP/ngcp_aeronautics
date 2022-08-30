clear all
close all
% Sigmoid
M    = 50;
alp0 = 0.47;
cl1 = 2*pi;
cl2 = 2;

cd1 = 0;
cf = 0;
cd0 = 0.01;

RN = @(y,U)(50000);

sgm  = @(alp)( (1+exp(-M*(alp-alp0))+exp(M*(alp+alp0))) ... 
 ./( (1+exp(-M*(alp-alp0))).*(1+exp(M*(alp+alp0)))  ));

cl = @(alp)(  (1-sgm(alp))*cl1.*alp + sgm(alp)*cl2.*sin(alp).*cos(alp)  );
cd = @(alp)(  (cd1*sin(alp).^2) + 2*1.02*cf/50000 + cd0 );

alp = linspace(-pi/2,pi/2,100);

figure()
plot(alp,sgm(alp));

figure()
plot(alp,cd(alp));

figure()
plot(alp,cl(alp));