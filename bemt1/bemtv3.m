% Implements blade element momentum theory from Rajan Gill and Raffaello
% D’Andrea Propeller Thrust and Drag in Forward Flight
% Using constant inflow

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
% y_in - radius at which the induced velocity is calculated

% Plan
% unpack structures
% Make thrust integral
% Lift and drag of the blade element


%psi - asimuth angle, zero at the projection of the frestream velocity on
%the propeller plane

function result = bemtv2(oper,geom,aero,envy)

    % Unpacking operating conditions
    bta   = oper.bta;
    omg   = oper.omg;
    v_inf = oper.v_inf;

    % Unpacking geometry
    c    = geom.c;
    tht  = geom.tht;
    Nb   = geom.Nb;
    R    = geom.R;

    % Environment
    rho = envy.rho;

    %Making aefoil model
    cl = aero.cl;
    cd = aero.cd;

    % Velocity
    Ut  = @(y,psi)(omg*y + v_inf*sin(bta)*sin(psi)); %tangent to the propeller
    Up  = @(y,psi,v_in)(v_inf*cos(bta) + v_in); % perpendicular to the propeller
    U   = @(y,psi,v_in)(sqrt(Ut(y,psi).^2 + Up(y,psi,v_in).^2)); %Air velocity normal to the chord line
    phi = @(y,psi,v_in)(atan2(Up(y,psi,v_in),Ut(y,psi))); % induced angle of attack
    alp = @(y,psi,v_in)(tht(y) - phi(y,psi,v_in));

    % Aerodynamcis
    % Drag and lift of blade element
    dLdy = @(y,psi,v_in)(0.5*rho*U(y,psi,v_in).^2.*cl(alp(y,psi,v_in)).*c(y));
    dDdy = @(y,psi,v_in)(0.5*rho*U(y,psi,v_in).^2.*cd(alp(y,psi,v_in)).*c(y));

    % Contribution to tangent and axial force from blade element dy at y,psi
    dTdy   = @(y,psi,v_in)(dLdy(y,psi,v_in).*cos(phi(y,psi,v_in)) - dDdy(y,psi,v_in).*sin(phi(y,psi,v_in)));
    dTaudy = @(y,psi,v_in)(dLdy(y,psi,v_in).*sin(phi(y,psi,v_in)) + dDdy(y,psi,v_in).*cos(phi(y,psi,v_in)));
    dQdy   = @(y,psi,v_in)(y.*(dLdy(y,psi,v_in).*sin(phi(y,psi,v_in)) + dDdy(y,psi,v_in).*cos(phi(y,psi,v_in))));

    % Momentum( BEMT according to the article theory)
    R_int_coef = 1; % In intro to heli aerodynamics this approach is used to account for tip vorticies
    dT_bemtdy = @(y,v_in)(4*v_in*rho*pi.*y.*sqrt(v_inf^2*sin(bta)^2 + (v_inf*cos(bta) + v_in).^2));
    T_bemt    = @(v_in)(integral(@(y)(dT_bemtdy(y,v_in)),0.2*R,R_int_coef*R));
    T_bet     = @(v_in)(Nb/(2*pi)*integral2(@(y,psi)(dTdy(y,psi,v_in)),0.2*R,R_int_coef*R,0,2*pi,'RelTol',1e-4));
    Tau_bet   = @(v_in)(Nb/(2*pi)*integral2(@(y,psi)(dTaudy(y,psi,v_in)),0.2*R,R_int_coef*R,0,2*pi,'RelTol',1e-4));
    Q_bet     = @(v_in)(Nb/(2*pi)*integral2(@(y,psi)(dQdy(y,psi,v_in)),0.2*R,R_int_coef*R,0,2*pi,'RelTol',1e-4));
    
    % Match v_in     % Matching blade element theory(bet) with blade element momentum theory(bemt)
    v_in = fzero(@(v_in)(T_bemt(v_in) - T_bet(v_in)),1);

    result.T    = T_bet(v_in);
    result.Tau  = Tau_bet(v_in);
    result.Q    = Q_bet(v_in);
    result.v_in = v_in;
%     result.testfun = @(y,psi)(dTdy(y,psi,v_in));
%     result.alp     = @(y,psi)(alp(y,psi,v_in));
    
end