clear all
close all
v_in = @(y,x)(y+x);

v_inav = @(y)(integral(@(x)(v_in(y,x)), 0,2))
