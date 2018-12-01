%obliczamy pochodna funkcji uzywajac metody polowienia
clc;
close all;
clear all;

%parametry
h = 0.05;
E = 0.01; %dokladnosc
a = 0;
b = 6;
x=a;
x_old = -99999;


%funkcja bazowa
f = @(x) x.^3 + x.^2 - 20*x;
fp = @(x) ( f(x + h) - f(x) )/h;
fpp = @(x) ( f(x + 2.*h) - 2.*f(x + h) + f(x) ) / h.^2;
iter = 0;

%x = -10:0.1:10;
%plot(x, f(x), x, fp(x), x, fpp(x));

while abs(x-x_old) >= E
  x_old = x;
  x = x - (fp(x) / fpp(x));
  iter = iter + 1;
endwhile

iter
x
