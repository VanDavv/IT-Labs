%obliczamy pochodna funkcji uzywajac metody polowienia
clc;
close all;
clear all;

%funkcja bazowa
F='x.^3 + x.^2 - 20*x';
f=inline(F);

%parametry
E = 0.01; %dokladnosc
a = 0;
b = 6;
L = b - a;
x1 = a+0.382*L;
x2 = a+0.618*L;
xm = (a+b)/2;
xp = -1; %inicjalizacja
iter = 0;

while L*(0.618^iter) > E
    iter = iter+1;
    if f(x1) < f(x2)
        b = x2;   
    else
        a = x1;   
    end
    L = b - a;
    x1 = a+0.382*L;
    x2 = a+0.618*L;
    xm = (a+b)/2;   
end

iter
xp = xm  %wynik
