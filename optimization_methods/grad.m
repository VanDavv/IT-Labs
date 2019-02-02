%lab03 - Metoda gradientu prostego
clc
clear all
close all

x0 = -5; % punkt startowy X
y0 = -5; % punkt startowy Y
bool = 0; % sluzy do zakonczenia petli
h = 0.05; % krok
e = 0.1; % epsilon
iter = 0; %liczba iteracji

f = inline('2*x.^2 + y.^2 + x.*y - 6*x - 5*y + 8'); %funkcja

[X,Y] = meshgrid(-5:0.1:5, -5:0.1:5);
contour(X,Y,f(X,Y), 50) 
hold on
plot(x0, y0, 'b o')	% narysowanie punktu startowego

Fx = (f(x0+h,y0) - f(x0,y0))/h;
Fy = (f(x0,y0+h) - f(x0,y0))/h;

gradient = [Fx, Fy]; % gradient
dl_grad = norm(gradient); %dlugosc gradientu

lambda = 0.15;

while (norm(gradient) >= e )
     
    x0 = x0 - (gradient(1)./dl_grad)*lambda;
    y0 = y0 - (gradient(2)./dl_grad)*lambda;
    
    iter = iter + 1;
    plot(x0,y0, '. r')
        
    Fx = (f(x0+h,y0) - f(x0,y0))/h;
    Fy = (f(x0,y0+h) - f(x0,y0))/h;
    
    gradient = [Fx, Fy]; % nasz gradient
    dl_grad = norm(gradient); %oblicza dlugosc naszego gradientu
end

plot(x0, y0, 'g o');
iter
x0
y0