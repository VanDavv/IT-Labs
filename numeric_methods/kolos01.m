X = 0:0.1:10;
h = 0.1;

F = @(x) sqrt(2*x);
F_p = @(x) x^(cos(x) - 1) * (cos(x) - x * log(x) * sin(x));
two_points_f = @(x) (F(x+h) - F(x)) / h;
three_points_f = @(x) (F(x+h) - F(x-h)) / (2 * h);
five_points_f = @(x) (1/(12*h)) * (F(x-2*h) - 8 * F(x-h) + 8 * F(x+h) - F(x+2*h));

a = two_points_f(2)