function fie = escspecfunIe(paramsesc,paramsbat,paramsmisc,Um,Im)
Iemax = paramsesc(1);
Re    = paramsesc(2);
Ge    = paramsesc(3);

Cb = paramsbat(1);
Rb = paramsbat(2);
Ub = paramsbat(3);
Kb = paramsbat(4);
Gb = paramsbat(5);

nr   = paramsmisc(1);
Iadd = paramsmisc(2);

fsigma = min((Um + Im*Re)/(Ub), 1);
fie    = fsigma*Im;
Ib     = nr*fie + Iadd;
fue    = Ub-Ib*Rb;
fib = Ib;

end