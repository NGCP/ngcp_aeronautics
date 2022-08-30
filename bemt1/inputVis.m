close all

figure()
plot(alp_vec*180/pi,Cl)
title('Cl')
hold on
plot(naca4412.alp,naca4412.cl);
hold off

figure()
plot(alp_vec*180/pi,Cd)
title('Cd')
hold on
plot(naca4412.alp,naca4412.cd);
hold off

alp_func = result.alp;
n = 100;
[Y,PSI] = meshgrid(linspace(0.2*geom.R,R,n),linspace(0,2*pi,n));
for i = 1:n
    for j = 1:n
        ALP(i,j) = alp_func(Y(i,j),PSI(i,j));
    end
end

figure()
surf(Y,PSI,ALP*180/pi,'edgecolor','none')
title('Angle of attack')
xlabel('Y');
ylabel('Psi')

