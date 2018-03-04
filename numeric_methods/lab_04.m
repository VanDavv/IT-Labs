X = 0:0.1:10;
h = 0.1;

F = @(x) x^(cos(x));
F_p = @(x) x^(cos(x) - 1) * (cos(x) - x * log(x) * sin(x));
two_points_f = @(x) (F(x+h) - F(x)) / h;
three_points_f = @(x) (F(x+h) - F(x-h)) / (2 * h);
five_points_f = @(x) (1/(12*h)) * (F(x-2*h) - 8 * F(x-h) + 8 * F(x+h) - F(x+2*h));

for i=1:length(X)
  Y(i) = F(X(i));
  Y_p(i) = F_p(X(i));
  Y_two(i) = two_points_f(X(i));
  Y_three(i) = three_points_f(X(i));
  Y_five(i) = five_points_f(X(i));
endfor  

plot(
  X, Y, "-b;F;", 
  X, Y_p, "-r;F';", 
  X, Y_two, "-g;F' - 2p;", 
  X, Y_three, "-k;F' - 3p;",
  X, Y_five, "-c;F' - 5p;"
);