function [Cl_vec,Cd_vec] = StC(alp_vec,StCParams)
    phi_nose = StCParams.phi_nose;
    phi_tail = StCParams.phi_tail;
    rc       = StCParams.rc;
    %Stall Coefficcients by C. Lindenburg, infinite aspect ratio
    Cd90 = 2.06;
    %phi_nose,phi_tail: angle of camber line to chord?
    %rc nose radius devided by camber

    %Flat plate
    Cn = @(alp)(sign(alp).*(Cd90*sin(abs(alp))./(0.56+0.44*sin(abs(alp)))));
    g  = 0.288*sqrt(rc);
    Ct = @(alp)(0.5*0.0075*cos(alp) + Cn(alp)*sin(g));

    Cl = @(alp)(Cn(alp).*cos(alp) - Ct(alp).*sin(alp));
    Cd = @(alp)(Cn(alp).*sin(alp) + Ct(alp).*cos(alp));
    
    Cl_vec = Cl(alp_vec);
    Cd_vec = Cd(alp_vec);
end