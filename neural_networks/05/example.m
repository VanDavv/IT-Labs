m = [1 -1 1; -1 1 1];
m= m';

net = newhop(m);
w = net.LW{1, 1};
b = net.b{1, 1};

[y, pf, af] = sim(net, 2, {}, m);

y'

a = {[0.9; 0.1; 0.8]};

[y, pf, af] = sim(net, {1 20}, {}, a);

y1 = cell2mat(y)

plot3(m(1, :), m(2, :), m(3, :), '*');
hold on
plot3(y1(1, :), y1(2, :), y1(3, :));
hold off