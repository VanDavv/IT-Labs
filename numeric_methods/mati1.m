
f = @(x) x ^ 2;

%x_min = input('X min: ');
%x_max = input('X max: ');

x_min = -20;
x_max = 20;

X = x_min:0.1:x_max;
for i=1:length(X)
  Y(i) = f(X(i));
endfor

plot(X, Y)