function fcm = propspecfunCm(paramsprop)
    %params
    A      = paramsprop(1);
    epsi   = paramsprop(2);
    lambda = paramsprop(3);
    ksi    = paramsprop(4);
    e      = paramsprop(5);
    Cfd    = paramsprop(6);
    alpha0 = paramsprop(7);
    K0     = paramsprop(8);
    Hp     = paramsprop(9);
    Dp     = paramsprop(10);
    Bp     = paramsprop(11); 
    
    Cd = Cfd + pi*A*K0^2/e*(epsi*atan(Hp/(pi*Dp)) - alpha0)^2/(pi*A + K0)^2;
    fct = 0.25*pi^3*lambda*ksi^2*Bp*K0*(epsi*atan(Hp/(pi*Dp)) - alpha0)/(pi*A + K0);
    fcm = 1/(8*A)*pi^2*Cd*ksi^2*lambda*Bp^2;
end