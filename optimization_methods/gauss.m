%lab 02 - Optymalizacja funkcji wielu zmiennych
clc
clear all

z = inline('2*x.^2+y.^2+x.*y-6*x-5*y+8');
ax = -5; 
by = 5;

E = 0.05;
yn = -4.5;
xn = -4.5;
xnp1= 5;
ynp1= 5;
[x,y]= meshgrid(-5:0.1:5);
f = z(x,y);
contour(x,y,f,50);
hold on
while (sqrt((xnp1-xn).^2+(ynp1-yn).^2)>E)
    xnp1 =xn;
    ynp1 = yn;
    a = ax; 
    b = by;
    while (abs(a-b)>E)
        L = b - a;
        x1 = a+0.382*L;
        x2 = a+0.618*L;
        xm =(a+b)/2;
        if z(x1, yn) < z(x2, yn)
            b=x2;
        else 
            a= x1;
        end
    end 
    a = ax; 
    b = by;
    xn=xm;
    line([xnp1, xn],[yn,yn])
    while (abs(a-b)>E)
    L = b - a;
    y1 = a+0.382*L;
    y2 = a+0.618*L;
    ym=(a+b)/2;
        if z(xn, y1) < z(xn, y2)
            b=y2;
        else 
            a=y1;
        end
    end 
    yn=ym;
    line([xn, xn],[ynp1,yn])
end
yn
xn

z(xn, yn)