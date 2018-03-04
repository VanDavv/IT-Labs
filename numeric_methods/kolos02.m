clear all;
# remenber:
# A = polyfit(X, Y, n-1)
# W(x) = polyval(A, x)

# X = input('X (input vector): ')
# Y = input('Y (input vector): ')
X = [-1, 0, 2, 5];
Y = [0, 1, -2, 0];

# p = input('p (level):');
p = 3;
psi = zeros(p+1);
F = zeros(p+1, 1);
for i=1:length(X)
  for j=0:p
    for k=0:p
      tempPsi(j+1, k+1) = X(i)^(k+j);
    end
    tempF(j+1, 1) = X(i)^j * Y(i);
  end
  psi += tempPsi;
  F += tempF;
end

psi
F

A = psi^-1 * F

x = min(X):0.1:max(X);
W = [0];
x_4 = 0;
for k=1:p+1
  W = W + A(k) * x.^(k-1);
end

for i=1:length(x)
  if (x(i) == 4)
    W(i)
  endif
endfor  

A


plot(X, Y, "ob; Input;", x, W);

title('aproxymation');