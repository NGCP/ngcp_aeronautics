% Implements blade element momentum theory from Rajan Gill and Raffaello
% D’Andrea Propeller Thrust and Drag in Forward Flight

% Inputs:
% propeller geometry
% geom
% c(y)  - chord length vs radius.
% tht(y) - twist angle vs radius
% r - propeller radius

% % propeller aerodynamics
% aero
% cl(al) - lift coeficient vs angle of attack of the airfoil
% cd(al) - drag coeficient vs angle of attack of the airfoil
% % Operation conditions

% oper
% v_inf - freestream velocity
% omg   - angular velocity of rotation
% bta    - angle of the disk plane to the frestream
% % environment
% envy
% rho - density
% eta - viscosity
% 
% % Outputs
% T    - Rotor thrust(axial force)
% D    - Drag
% Q    - torque
% v_in - induced velocity.

% Plan
% unpack structures
% Make thrust integral
% Lift and drag of the blade element


%psi - asimuth angle, zero at the projection of the frestream velocity on
%the propeller plane
clear all
close all

oper.bta   = pi/2;
oper.omg   = 1;
oper.v_inf = 0;

geom.tht   = @(y)(pi/12*ones(size(y)));
geom.c     = @(y)(ones(size(y)));
geom.Nb    =2;

%Environment
envy.rho = 1.225;
envy.eta = 1.81*10^(-5);

% Unpacking operating conditions
bta   = oper.bta;
omg   = oper.omg;
v_inf = oper.v_inf;

% Unpacking geometry
v_in = @(y)(zeros(size(y)));
c    = geom.c;
tht  = geom.tht;
Nb   = geom.Nb;

% Environment
rho = envy.rho;
eta = envy.eta;

% Velocity
Ut  = @(y,psi)(omg*y + v_inf*sin(bta)*sin(psi)); %tangent to the propeller
Up  = @(y,psi)((v_inf*cos(bta) + v_in(y))); % perpendicular to the propeller
U   = @(y,psi)(sqrt(Ut(y,psi).^2 + Up(y,psi).^2)); %Air velocity normal to the chord line
phi = @(y,psi)(atan(Up(y,psi)./Ut(y,psi))); % induced angle of attack
alp = @(y,psi)(tht(y) - phi(y,psi));

%Making aefoil model
M    = 50;
alp0 = 0.47;
cl1 = 2*pi;
cl2 = 2;

cd1 = 0;
cf = 0;
cd0 = 0.01;

sgm  = @(alp)( (1+exp(-M*(alp-alp0))+exp(M*(alp+alp0))) ... 
 ./( (1+exp(-M*(alp-alp0))).*(1+exp(M*(alp+alp0)))  ));
RN = @(y,U)(rho*U.*y/eta);
cl = @(alp)(  (1-sgm(alp))*cl1.*alp + sgm(alp)*cl2.*sin(alp).*cos(alp)  );
cd = @(alp,y,psi)(  (cd1*sin(alp).^2) + 2*1.02*cf./sqrt(RN(y,U(y,psi))) + cd0 );

% Aerodynamcis
dLdy = @(y,psi)(0.5*rho*U(y,psi).^2.*cl(alp(y,psi)).*c(y));
dDdy = @(y,psi)(0.5*rho*U(y,psi).^2.*cd(alp(y,psi),y,psi).*c(y));

dT_betdy = @(y)(Nb/(2*pi)*integral(@(psi)(dLdy(y,psi).*cos(phi(y,psi) - dDdy(y,psi).*sin(phi(y,psi)))),0,2*pi));
dD_betdy = @(y)(Nb/(2*pi)*integral(@(psi)(dLdy(y,psi).*sin(phi(y,psi) + dDdy(y,psi).*cos(phi(y,psi)))),0,2*pi));
dQ_betdy = @(y)(y*Nb/(2*pi)*integral(@(psi)(dLdy(y,psi).*sin(phi(y,psi) + dDdy(y,psi).*cos(phi(y,psi)))),0,2*pi));

% Momentum( BEMT according to the article theory)
dT_bemtdy = @(y)(4*v_in(y)*rho*pi.*y.*sqrt(v_inf^2*sin(bta)^2 + (v_inf*cos(bta) + v_in(y)).^2));

% Build fixed point iteration for induced velocity
% Do fixed point iteration, find that velocity
% Calculate all other integrals
% Profit