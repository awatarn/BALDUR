%% phy150solve.m
clc
close all
clear
%%
fun = @phy150fn;
x0 = 1e-9;
x = fsolve(fun,x0)

break
1.0939e-5