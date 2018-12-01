syms z(X, Y)
z(X, Y) = 2*X^2 + Y^2 + X*Y -6*X -5*Y + 8;

grad_x = diff(z, X)
grad_y = diff(z, Y)

grad_k = [19 10]

learning_rate = 0.2
epsylon = 0.01

while norm(grad_k) > epsylon
    derr_grad_k = [grad_x(grad_k(1), grad_k(2)) grad_y(grad_k(1), grad_k(2))];
    grad_k = eval(grad_k - (learning_rate / norm(grad_k)) * der_grad_k)
end


