clear all
close all

load('data/apc1050imported.mat');

%Environment
envy.rho = 1.225;
envy.eta = 1.81*10^(-5);

oper.bta   = 0;
oper.omg   = 6708*pi/30;
oper.v_inf = 0;

%% Matching aerodynamic model
alp = linspace(-pi/2,pi/2);
alp_vec = linspace(-pi,pi,200);
params4aerocoefs.cd0   = 0.006;
params4aerocoefs.cd90  = 1.28;
params4aerocoefs.alp0  = -5*pi/180;
params4aerocoefs.alp_sn = -16*pi/180;
params4aerocoefs.alp_sp =  10*pi/180;
[Cl,Cd] = aerocoefs(alp_vec,params4aerocoefs);
aero.cl = @(alp)(interp1(alp_vec,Cl,alp,'cubic'));
aero.cd = @(alp)(interp1(alp_vec,Cd,alp,'cubic'));
result = bemtv2(oper,geom,aero,envy);
testfun = result.testfun;

figure()
n = 200;
[Y,PSI] = meshgrid(linspace(0,geom.R,n),linspace(0,2*pi,n));
for i = 1:n
    for j = 1:n
        res(i,j) = testfun(Y(i,j),PSI(i,j));
    end
end
surf(Y/geom.R,PSI,res,'EdgeColor','none');
colorbar