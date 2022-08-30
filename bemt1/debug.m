clear all
close all
clc

oper.bta   = 0;
oper.omg   = 100;
oper.v_inf = 0;

geom.tht   = @(y)(pi/12*ones(size(y)));
geom.c     = @(y)(ones(size(y)));
geom.Nb    =2;
geom.R     =0.1;

%Environment
envy.rho = 1.225;
envy.eta = 1.81*10^(-5);

%% Matching aerodynamic model
alp = linspace(-pi/2,pi/2);
alp_vec = linspace(-pi,pi,200);
params4aerocoefs.cd0   = 0.006;
params4aerocoefs.cd90  = 1.28;
params4aerocoefs.alp0  = -4*pi/180;
params4aerocoefs.alp_sn = -16*pi/180;
params4aerocoefs.alp_sp =  10*pi/180;
[Cl,Cd] = aerocoefs(alp_vec,params4aerocoefs);
cl = @(alp)(interp1(alp_vec,Cl,alp));
cd = @(alp)(interp1(alp_vec,Cd,alp));

%Making aefoil model
aero.cl = cl;
aero.cd = cd;

result =  bemtv2(oper,geom,aero,envy);
testfun = result.testfun;
v_in    = result.v_in;
%Visualizaton
figure()
title("Cl")
plot(alp*180/pi,cl(alp));
xlabel('alpha, deg');
ylabel('cl');
grid on
grid minor

figure()
title("Cd")
plot(alp*180/pi,cd(alp));
xlabel('alpha, deg');
ylabel('cd');
grid on
grid minor

figure()
y = linspace(0,geom.R,200);
plot(y,v_in(y));

figure()
[V,Y] = meshgrid(linspace(-8,8,200),linspace(0.01*geom.R,geom.R,200));
for i = 1:200
    for j = 1:200
        v_in_dt = @(y)(V(i,j));
        res(i,j) = result.dT_betdy(Y(i,j),v_in_dt) - result.dT_bemtdy(Y(i,j),v_in_dt);
    end
end
surf(V,Y,res,'EdgeColor','none');
colorbar

