function fum = motorspecfunUm(paramsmotor,M,N)
Kv0    = paramsmotor(1);
Immax  = paramsmotor(2);
Im0    = paramsmotor(3);
Um0    = paramsmotor(4);
Rm     = paramsmotor(5);
Gm     = paramsmotor(6);

fum = Rm*((M*Kv0*Um0)/(9.55*(Um0-Im0*Rm)) + Im0) + ...
    (Um0 - Im0*Rm)/(Kv0*Um0)*N;

fim = (M*Kv0*Um0)/(9.55*(Um0-Im0*Rm)) + Im0;
end