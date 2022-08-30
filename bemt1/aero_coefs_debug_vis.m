alp_vec = linspace(-30,30)*pi/180;

R = geom.R;
% aero_coefs_debug needs to be run before
y = linspace(0.2*R,R);
psi = linspace(0,2*pi);

[Y,PSI] = meshgrid(y,psi);

alp_fun = result.alp;
dq_fun  = result.dQ;
phi     = result.phi;
cl_fun  = aero.cl;
cd_fun  = aero.cd;

cl_vec = cl_fun(alp_vec);
cd_vec = cd_fun(alp_vec);

for i = 1:length(psi)
    for j = 1:length(y)
        A(j,i)  = alp_fun(Y(j,i),PSI(j,i));
        DQ(j,i) = dq_fun(Y(j,i),PSI(j,i));
        PHI(j,i)= phi(Y(j,i),PSI(j,i));
    end
end

figure()
surf(Y,PSI/(2*pi),A*180/pi);
title('Alpha')

figure()
surf(Y,PSI/(2*pi),DQ);
title('Dq')


figure()
title('Phi')
surf(Y,PSI/(2*pi),PHI/(2*pi)*360);

figure()
title('Cl')
plot(alp_vec*180/pi,cl_vec);

figure()
title('Cd')
plot(alp_vec*180/pi,cd_vec)