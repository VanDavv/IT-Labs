F = @(x) x^3 + 2*x^2 - 100;
a = 3;
b = 100;

X = a:0.1:b;
for i=1:length(X)
  Y(i) = F(X(i));
endfor

a_temp = a;
b_temp = b;
ex = 0.0000000001;
e0 = 0.0000000001;

while(abs(a_temp - b_temp) > ex)
  x0 = (a_temp + b_temp) / 2;
  f0 = F(x0);
  if(f0 < e0)
    x0
  endif
  if(F(a_temp) * F(b_temp) < 0)
    b_temp = x0;
  else
    a_temp = x0;
  endif
endwhile

#plot(X, Y);