X = eye(11) + rot90(eye(11));
X = X ./ X;
X(isnan(X)) = 0;
X = ones(11) .* -1 + X .* 2;

T = ones(11) * -1;
T(1, :) = ones(11, 1);
T(:, 6) = ones(11, 1);

K = [ ones(5, 1), rot90(eye(5)), zeros(5);
      1, zeros(1, 5), zeros(1, 5);
      ones(5, 1), eye(5), zeros(5);
    ] * 2 - 1;

L = zeros(11);
L(11, 1:8) = ones(8, 1);
L(:, 1) = ones(1, 11);
L = L * 2 - 1;

F = zeros(11);
F(:, 1) = ones(1, 11);
F(1, 1:6) = ones(6, 1);
F(6, 1:6) = ones(6, 1);
F = F * 2 - 1;

E = zeros(11);
E(:, 1) = ones(1, 11);
E(1, 1:6) = ones(6, 1);
E(6, 1:6) = ones(6, 1);
E(11, 1:6) = ones(6, 1);
E = E * 2 - 1;

I = zeros(11);
I(:, 6) = ones(11, 1);
I = I * 2 - 1;

H = zeros(11);
H(:, 4) = ones(11, 1);
H(:, 8) = ones(11, 1);
H(6, 4:8) = ones(1, 5);
H = H * 2 - 1;

Z = rot90(eye(11));
Z(1, :) = ones(1, 11);
Z(11, :) = ones(1, 11);
Z = Z * 2 -1;

N = eye(11);
N(:, 1) = ones(11, 1);
N(:, 11) = ones(11, 1);
N = N * 2 - 1;

% figure(10);
% subplot(5, 2, 1)
% imagesc(X);
% subplot(5, 2, 2)
% imagesc(T)
% subplot(5, 2, 3)
% imagesc(K)
% subplot(5, 2, 4)
% imagesc(L)
% subplot(5, 2, 5)
% imagesc(F)
% subplot(5, 2, 6)
% imagesc(E)
% subplot(5, 2, 7)
% imagesc(I)
% subplot(5, 2, 8)
% imagesc(H)
% subplot(5, 2, 9)
% imagesc(Z)
% subplot(5, 2, 10)
% imagesc(N)

in = [reshape(X, 121, 1), reshape(T, 121, 1), reshape(K, 121, 1), ...
    reshape(L, 121, 1), reshape(F, 121, 1), reshape(E, 121, 1), ...
    reshape(I, 121, 1), reshape(H, 121, 1), reshape(Z, 121, 1), reshape(N, 121, 1)];

net = newhop(in);
w = net.LW{1, 1};
b = net.b{1, 1};
dlmwrite('w.txt', w);
dlmwrite('b.txt', b);

parse(net, withnoise(X), 'X')
parse(net, withnoise(T), 'T')
parse(net, withnoise(K), 'K')
parse(net, withnoise(L), 'L')
parse(net, withnoise(F), 'F')
parse(net, withnoise(E), 'E')
parse(net, withnoise(I), 'I')
parse(net, withnoise(H), 'H')
parse(net, withnoise(Z), 'Z')
parse(net, withnoise(N), 'N')

function out = withnoise(in)
    in_ = in(:, :);
    in_(in_<0) = 0;
    noise = randi([0, 1], [11, 11]);
    noise = noise ./ randi([0, 1], [11, 11]);
    noise = noise ./ randi([0, 1], [11, 11]);
    noise = noise ./ randi([0, 1], [11, 11]);
    noise(~isfinite(noise)) = 0;
    
    mask = randi([0, 2], [11, 11]);
    mask = mask ./ mask;
    mask(~isfinite(mask)) = 0;
    
    in_ = (in_ + noise) .* mask;
    in_ = in_ ./ in_;
    in_(~isfinite(in_)) = 0;
    out = in_ * 2 - 1;
end

function parse(net, we, t)
    in_ = reshape(we, 121, 1);

    [y, pf, af] = sim(net, {1 20}, {}, {in_});

    y1 = cell2mat(y);

    y1 = reshape(y1(:, end), 11, 11);
    figure();
    subplot(1, 2, 1);
    imagesc(we);
    title(strcat(t, ' noised'));
    subplot(1, 2, 2);
    imagesc(y1);
    title(strcat(t, ' cleared'));
end