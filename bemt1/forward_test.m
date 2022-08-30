clear all
close all
clc

load('data/props/apc947himera2.mat')
load('data/apc9x47/apc9x47_exp_data.mat')

apc947 = apc947exp;
geom = apc947.geom;
aero = apc947.aero;


R = geom.R;
envy.rho = 1.225;
envy.eta = 1.81*10^(-5);

% Static run
omega = [2763;3062;3310;3622;3874;4153;4422;4687;4942;5226;5473;5736;6026;6285;6554;6768]/60*2*pi; % https://m-selig.ae.illinois.edu/props/volume-1/data/apcsf_9x4.7_static_kt1032.txt
oper.v_inf   = 0;
oper.bta = 0;

% For coefs calc
rho = envy.rho;
n   = omega/(2*pi); %rps
D   = 2*R;

for i = 1:length(omega)
    oper.omg = omega(i);
    result(i) = bemtv3(oper,geom,aero,envy);
    CT(i)  = result(i).T/(rho*n(i)^2*D^4);  % Thrust
    CP(i)  = result(i).Q*omega(i)/(rho*n(i)^3*D^5);  % Torque
end

apc9x47sf_static_th.RPM = omega*60/(2*pi);
apc9x47sf_static_th.CT = CT;
apc9x47sf_static_th.CP = CP;

clear result CT CP
%Dynamic Run
RPM = [4008,5013,6004,6029,6815,6819];
n   = [4008,5013,6004,6029,6815,6819]/60; %rps, for coefs
expData = {apc9x47sf_4008,apc9x47sf_5013,apc9x47sf_6004,apc9x47sf_6029, ...
    apc9x47sf_6815,apc9x47sf_6819};

for i = 1:length(RPM)
    J = expData{i}.J;
    V = J*n(i)*D;
    oper.omg = n(i)*2*pi;
    oper.bta = 0;
    for j = 1:length(V)
        oper.v_inf = V(j);
        result(j) = bemtv3(oper,geom,aero,envy);
        CT(j)  = result(j).T/(rho*n(i)^2*D^4);  % Thrust
        CP(j)  = result(j).Q*oper.omg/(rho*n(i)^3*D^5);  % Torque
        fprintf('pip /n');
    end
    thData{i}.J = J;
    thData{i}.CT = CT';
    thData{i}.CP = CP';
    clear result CT CP
end

apc9x47sf_4008_th = struct2table(thData{1});
apc9x47sf_5013_th = struct2table(thData{2});
apc9x47sf_6004_th = struct2table(thData{3});
apc9x47sf_6029_th = struct2table(thData{4});
apc9x47sf_6815_th = struct2table(thData{5});
apc9x47sf_6819_th = struct2table(thData{3});






