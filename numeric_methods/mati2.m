
f = @(x, y) x ^ 2 + y ^ 3;

%x_min = input('X min: ');
%x_max = input('X max: ');

x_min = -20;
x_max = 20;

y_min = -5;
y_max = 5;

X = x_min:0.1:x_max;

for i=1:length(X)
  Y(i) = y_min + ((abs(y_min) + abs(y_max)) / length(X)) * (i - 1);
  Z(i) = f(X(i), Y(i));
endfor

plot3(X, Y, Z);