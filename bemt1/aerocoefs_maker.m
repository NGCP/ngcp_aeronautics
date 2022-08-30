% Script to make airfoil model.
clear all
clc

load('data\props\apc947.mat');
load('data\naca4412himera2.mat');
naca4412 = naca4412himera2;

% Reynolds number
RPM   = 6819;
omega = RPM/60*2*pi;
R   = 4.5*2.54*10^(-2);
rho = 1.225;
eta = 1.81*10^(-5);
c   = 0.2*R;
Re  =  rho*R*omega*c/eta;

%Making StC model for naca 4412
m = 4/100;
p = 4/10;
t = 12/100;
StCParams.phi_tail = 0;
StCParams.phi_nose = atan(2*m/p);
StCParams.rc = 1.1019*t^2;
alp_vec = linspace(-pi/2,pi/2);
[Cl_vec,Cd_vec] = StC(alp_vec,StCParams);
% 
% % %Making new prop model
% apc947exp.geom = apc947.geom;
% cd_fun = @(alp)(interp1(alp_vec,Cd_vec,alp));
% cl_fun = @(alp)(interp1(alp_vec,Cl_vec,alp));
% apc947exp.aero.cl = cl_fun;
% apc947exp.aero.cd = cd_fun;

% Using direct interpolation
apc947exp.geom = apc947.geom;
cd_fun = @(alp)(interp1(naca4412.alp*pi/180,naca4412.cd,alp,'linear','extrap'));
cl_fun = @(alp)(interp1(naca4412.alp*pi/180,naca4412.cl,alp,'linear','extrap'));
apc947exp.aero.cl = cl_fun;
apc947exp.aero.cd = cd_fun;
plotPropAndAiroil(apc947,naca4412)
plotPropAndAiroil(apc947exp,naca4412)


function plotPropAndAiroil(prop,airfoil)
    alp_vec = linspace(-50,50)*pi/180;
    cd_func  = prop.aero.cd;
    cl_func  = prop.aero.cl;

    figure()
    plot(airfoil.alp,airfoil.cl,'*');
    title("Cl");
    xlabel("alpha, deg");
    ylabel("Cl");
    grid on
    grid minor
    axis([-50,50,-inf,inf])
    hold on
    plot(alp_vec*180/pi,cl_func(alp_vec),'--');
    hold off

    figure()
    plot(airfoil.alp,airfoil.cd,'*');
    title("Cd");
    xlabel("alpha, deg");
    ylabel("Cd");
    grid on
    grid minor
    axis([-50,50,-inf,inf])
    hold on
    plot(alp_vec*180/pi,cd_func(alp_vec),'--');
    hold off
end

