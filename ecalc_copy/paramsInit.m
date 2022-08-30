clear all
close all

%prop
A      = 5;
epsi   = 0.85;
lambda = 0.75;
ksi    = 0.55;
e      = 0.83;
Cfd    = 0.015;
alpha0 = 0;
K0     = 6.11;
Hp     = 10*2.54*10^(-2);
Dp     = 20*2.54*10^(-2);
Bp     = 2;
Gp     = 10/1000;
paramsprop = [A epsi lambda ksi e Cfd alpha0 K0 Hp Dp Bp Gp];

%motor
Kv0    = 285;
Immax  = 60;
Im0    = 1.1;
Um0    = 10;
Rm     = 0.046;
Gm     = 267/1000;
paramsmotor = [Kv0 Immax Im0 Um0 Rm Gm];

%esc
Iemax = 50;
Re    = 0.005;
Ge    = 65/1000;
paramsesc = [Iemax Re Ge];

%bat
Cb = 46200;
Rb = 0.0051;
Ub = 22.2;
Kb = 24;
Gb = 6006/1000;
paramsbat = [Cb Rb Ub Kb Gb];

%misc
nr   = 6;
Iadd = 0;
Cmin = 0.15*Cb;
G    = 147.17;
paramsmisc = [nr Iadd Cmin G];
