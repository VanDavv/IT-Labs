load data/dane1.txt
we = dane1';
net = newc(minmax(we), 4);
w = net.IW{1}
plot(we(1, :), we(2,:), 'b+', w(:,1), w(:, 2), 'go')
hold on

net.trainParam.epochs = 50;
net = train(net, we);

w = net.IW{1}
plot(we(1,:),we(2,:),'b+', w(:,1),w(:,2),'ro')
hold off
