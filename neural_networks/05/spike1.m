X = [
 1, -1, 1;
 -1, 1, -1;
 1, -1, 1;
]
T = [ 1, 1, 1;
 -1, 1, -1;
 -1, 1, -1;
]

imagesc(X)

in = [reshape(X, 9, 1), reshape(T, 9, 1)]

net = newhop(in);
w = net.LW{1, 1};
b = net.b{1, 1};

t1 = [ 1, 1, 1;
 1, 1, -1;
 -1, 1, -1;
]

in1 = reshape(t1, 9, 1);

[y, pf, af] = sim(net, {1 20}, {}, {in1});

y1 = cell2mat(y)

y1 = reshape(y1(:, end), 3, 3);
figure(2);
subplot(1, 2, 1)
imagesc(t1);
subplot(1, 2, 2)
imagesc(y1)