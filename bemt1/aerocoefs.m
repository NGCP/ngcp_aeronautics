function [Cl,Cd] = aerocoefs(alp,params4aerocoefs)
 cd0 = params4aerocoefs.cd0;
 cd90 = params4aerocoefs.cd90;
 alp0 = params4aerocoefs.alp0;
 alp_sn = params4aerocoefs.alp_sn;
 alp_sp = params4aerocoefs.alp_sp;
 % before stall
 cl_ns  = @(alp)(2*pi*(alp-alp0));
 cd_ns  = @(alp)(2*pi*(alp-alp0).*tan(alp-alp0) + cd0*(sin(alp-alp0).^2 + cos(alp-alp0).^2));
 % after stall
 cn = @(alp)(sign(alp).*cd90*sin(abs(alp-alp0))./(0.56+0.44*sin(abs(alp-alp0))));
 ct = @(alp)(0.5*cd0*cos(alp-alp0));
 cl = @(alp)(cn(alp).*cos(alp-alp0) - ct(alp).*sin(alp-alp0));
 cd = @(alp)(cn(alp).*sin(alp-alp0) + ct(alp).*cos(alp-alp0));
 
 for i = 1:length(alp)
     if (alp(i) > alp_sn)&&(alp(i) < alp_sp)
         Cl(i) = cl_ns(alp(i));
         Cd(i) = cd_ns(alp(i));
     else
         Cl(i) = cl(alp(i));
         Cd(i) = cd(alp(i));
     end
 end
end