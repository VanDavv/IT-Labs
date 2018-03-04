n = 10;
a = 0;
b = 10;
h = (b - a) / n;

F = @(x) x^(cos(x));

for i=1:n+1
  X(i) = h * (i - 1) + a;
  Y(i) = F(X(i));
endfor

quad(F, a, b)

J1 = 0;
for i=1:n
  J1 += h * Y(i);
endfor

J1

J2 = h * (F(a) / 2 + F(b) / 2);
for i=2:n
  J2 += h * Y(i);
endfor
J2

J3 = (h/3) * (F(a) + F(b));
for i=2:n
  if (rem (i, 2) == 0)
    J3 += (h/3) * 4 * Y(i);
  else
    J3 += (h/3) * 2 * Y(i);
  endif
endfor

J3

x = min(X):0.1:max(X);
for i=1:length(x)
  y(i) = F(x(i));
endfor

n_monte = 1000;
positives = 0;
X_rand = rand(1, n_monte) * (b - a) + a;
Y_rand = rand(1, n_monte) * (max(y) - min(y)) + min(y);
for i=1:n_monte
  if (F(X_rand(i)) > Y_rand(i))
    X_pos(i) = X_rand(i);
    Y_pos(i) = Y_rand(i);
    positives += 1;
  else
    X_neg(i) = X_rand(i);
    Y_neg(i) = Y_rand(i);
  endif
endfor

monte = (positives / n_monte) * ( (max(y) - min(y)) * (b - a));
monte

plot(X_neg, Y_neg, "xr; neg;", X_pos, Y_pos, "og; pos;", x, y);



