% Running bemt o find out w/hy Cp is lower

clear all
clc
load('data/props/apc947himera2.mat')
apc947 = apc947exp;
geom = apc947.geom;
aero = apc947.aero;
aero.cd = @(alp)(apc947.aero.cd(alp));
aero.cl = @(alp)(apc947.aero.cl(alp));

R = geom.R;
envy.rho = 1.225;
envy.eta = 1.81*10^(-5);

oper.v_inf   = 10.44;
oper.bta = 0;
oper.omg = 5013/60*2*pi;
n = oper.omg/(2*pi);
D = 2*R;
result = bemtv2(oper,geom,aero,envy);

Ct_exp = 0.0252;
Cp_exp = 0.0286;

Ct_th = result.T/(envy.rho*n^2*D^4);
Cp_th = result.Q*oper.omg/(envy.rho*n^3*D^5);

err_ct = (Ct_th-Ct_exp)/Ct_exp*100
err_cp = (Cp_th-Cp_exp)/Cp_exp*100