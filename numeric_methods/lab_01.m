clear all;
# remenber:
# A = polyfit(X, Y, n-1)
# W(x) = polyval(A, x)

# X = input('X (input vector): ')
# Y = input('Y (input vector): ')
X = [1, 2, 3, 4, 5, 6, 7, 8];
Y = [2, 4, 8, 16, 16, 8, 4, 2];

n = length(X);

for i=1:n
  for j=1:n
    V(i, j) = X(i)^(j-1);
  end
end  

A = inverse(V)*Y';

x = min(X):0.1:max(X);

W = [0];
for k=1:n
  W = W + A(k) * x.^(k-1);
end

plot(X, Y, "ob; Input;", x, W)
text = 'W(x) = ';

for i=1:n
  text = text + num2str(A(i)) + 'x^' + num2str(i)
end
  
title(text)