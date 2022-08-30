clear all
close all
clc

load('data/apc1050imported.mat');


%Environment
envy.rho = 1.225;
envy.eta = 1.81*10^(-5);

%% Matching aerodynamic model
alp = linspace(-pi/2,pi/2);
alp_vec = linspace(-pi,pi,200);
params4aerocoefs.cd0   = 0.003;
params4aerocoefs.cd90  = 1.28;
params4aerocoefs.alp0  = -5*pi/180;
params4aerocoefs.alp_sn = -16*pi/180;
params4aerocoefs.alp_sp =  10*pi/180;
[Cl,Cd] = aerocoefs(alp_vec,params4aerocoefs);
cl = @(alp)(interp1(alp_vec,Cl,alp,'cubic'));
cd = @(alp)(interp1(alp_vec,Cd,alp,'cubic'));

%Making aefoil model
aero.cl = cl;
aero.cd = cd;

oper.bta   = pi/4;
oper.omg   = 100;
oper.v_inf = 0;

omg = linspace(2508,6708,10)*2*pi/60;

for i = 1:10
    oper.omg = omg(i);
    result = bemtv2(oper,geom,aero,envy);
    T(i) = result.T;
    Q(i) = result.Q;
    Ct(i) = T(i)/(envy.rho*(omg(i)/(2*pi))^2*(geom.R*2)^4);
    Cp(i) = Q(i)*omg(i)/(envy.rho*(omg(i)/(2*pi))^3*(geom.R*2)^5);
end

figure()
subplot(2,1,1)
plot(apce_10x5_static_pg0819.RPM,apce_10x5_static_pg0819.CT,'*r')
hold on
plot(omg*30/pi,Ct)
hold off
xlabel('RPM')
ylabel('Ct')
grid on
grid minor

subplot(2,1,2)
plot(apce_10x5_static_pg0819.RPM,apce_10x5_static_pg0819.CP,'*r')
hold on
plot(omg*30/pi,Cp)
xlabel('RPM')
ylabel('Cp')
grid on
grid minor
hold off

