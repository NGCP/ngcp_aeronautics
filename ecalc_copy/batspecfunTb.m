function ftb = batspecfunTb(paramsbat,paramsmisc,Ib)
Cb = paramsbat(1);
Rb = paramsbat(2);
Ub = paramsbat(3);
Kb = paramsbat(4);
Gb = paramsbat(5);

Cmin = paramsmisc(3);
ftb = (Cb - Cmin)/Ib*60/1000;
end