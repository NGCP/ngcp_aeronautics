R = 10/2*2.54*10^(-2);
tht_vec = apce_10x5_geom.beta*pi/180;
y_vec   = apce_10x5_geom.r_R*R;
c_vec   = apce_10x5_geom.c_R*R;
Nb = 2;

geom.tht   = @(y)(interp1(y_vec,tht_vec,y));
geom.c     = @(y)(interp1(y_vec,c_vec,y));
geom.Nb    = Nb;
geom.R     = R;