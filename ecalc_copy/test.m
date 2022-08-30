paramsInit

Cm = propspecfunCm(paramsprop);
Ct = propspecfunCt(paramsprop);
Dp = paramsprop(10);
nr = paramsmisc(1);
G  = paramsmisc(4);

rho = 1.18;

%drag area calc by ecalc method
F = 1.2;
% Hypotesisis:
% Top blue area is used
% Total weted area is used
% Crossectional area is used
%h1
d_arm   = 2.5/100;
h_multi = 0.1;
Rpmax   = F/2*sin(pi/nr);
Rhub    = F/2*(1-sin(pi/nr));
harm    = F/2-Rhub;
Shub    = pi*Rhub^2;
P       = 2*pi*Rhub + 2*nr*harm;
Sarms   = nr*harm*d_arm;
S       = (Sarms + Shub) + P*h_multi*0;

C1 = 3;
C2 = 1.5;

%Problem 4
V = @(th)(sqrt(2*G*tan(th)/(rho*S*(C1*(1-cos(th)^3) + C2*(1-sin(th)^3)))));
N = @(th)(60*sqrt(G/(rho*Ct*Dp^4*nr*cos(th))));
M = @(th)(G*Cm*Dp/(Ct*nr*cos(th)));

Um = @(th)(motorspecfunUm(paramsmotor,M(th),N(th)));
Im = @(th)(motorspecfunIm(paramsmotor,M(th),N(th)));

Ib = @(th)(escspecfunIb(paramsesc,paramsbat,paramsmisc,Um(th),Im(th)));
T  = @(th)(batspecfunTb(paramsbat,paramsmisc,Ib(th)));
Z  = @(th)(60*V(th)*T(th));

funminZ = @(th)(-Z(th));
thMaxZ = fminbnd(funminZ,0,pi/2); 
Zmax = Z(thMaxZ);
Thover = T(0);
