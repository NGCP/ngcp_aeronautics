psi = linspace(0,2*pi,200);
y   = linspace(0,1,200);

[PSI,Y] = meshgrid(psi,y);
U_grid  = U(Y,PSI);
Ut_grid = Ut(Y,PSI);
Up_grid = Up(Y,PSI);
phi_grid= phi(Y,PSI);
alp_grid = alp(Y,PSI);

figure()
title('U')
surf(PSI,Y,U_grid,'EdgeColor','none');

figure()
title('Ut')
surf(PSI,Y,Ut_grid,'EdgeColor','none');

figure()
title('Up')
surf(PSI,Y,Up_grid,'EdgeColor','none');

figure()
title('phi')
surf(PSI,Y,Up_grid,'EdgeColor','none');


figure()
title('alp')
surf(PSI,Y,alp_grid,'EdgeColor','none');