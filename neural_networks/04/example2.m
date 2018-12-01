load data/dane3d3.txt
we = dane3d3';
net = newc(minmax(we),3);
w = net.IW{1}
plot3(we(1,:),we(2,:),we(3,:),'b+',w(:,1),w(:,2),w(:,3),'go'); hold on;
for i=1:20
 net.trainParam.epochs = 1;
 net = train(net,we);
 w = net.IW{1};
 plot3(w(:,1),w(:,2),w(:,3),'go');
end
w = net.IW{1}
plot3(w(:,1),w(:,2),w(:,3),'ro'); hold off
vec2ind(sim(net, [0.1; 0.1; 0.1]))