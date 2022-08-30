clear all
close all
clc

%% Use bemtv2 to make torque vs (omega, v _air,alpha), thrust vs (omega, v _air, alpha), tangential vs (omega, v_air, alpha)
%omega limits in rad/s
omg_1 = 1000/60*2*pi;
omg_2 = 14000/60*2*pi;
n_omg = 5; % number of points along omega axis

%v_air limits in m/s
v_1 = 0;
v_2 = 26.8224;
n_v = 5; % number of points 

%inclanation limits in rad
bta_1 = 0;
bta_2 = pi/2;
n_bta = 5;

load('data/props/apc947himera2.mat')
geom = apc947exp.geom;
aero = apc947exp.aero;
%Environment
envy.rho = 1.225;
envy.eta = 1.81*10^(-5);



%% Analysis
% Making propeller operation points
omg_vec = linspace(omg_1,omg_2,n_omg);
v_vec   = linspace(v_1,v_2,n_v);
bta_vec = linspace(bta_1,bta_2,n_bta);
[OMG,V,BTA] = meshgrid(omg_vec,v_vec,bta_vec);

vlad_doesnt_know_math = 0;
T = zeros(length(omg_vec),length(v_vec),length(bta_vec));
Q = T;
Tau = Q;
V_in = Tau;
for i = 1:n_omg
    for j = 1:n_v
        for k = 1:n_bta
            oper.omg      = OMG(i);
            oper.v_inf    = V(j);
            oper.bta    = BTA(k);
            result(i,j,k) =  bemtv3(oper,geom,aero,envy);
            T(i,j,k)   = result(i,j,k).T; % Thrust
            Q(i,j,k)   = result(i,j,k).Q; % Torque
            Tau(i,j,k) = result(i,j,k).Tau; % Tangential force
            V_in(i,j,k) = result(i,j,k).v_in;
            vlad_doesnt_know_math = vlad_doesnt_know_math+1;
            display(vlad_doesnt_know_math)

        end
    end
end

