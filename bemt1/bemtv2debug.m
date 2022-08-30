tefun = @(y,psi)(dTdy(y,psi,v_in));

[Y,PSI] = meshrid(linspace(0,R,200),linspace(0,2*pi,200));

surf(Y,PS,tefun(Y,PSI));