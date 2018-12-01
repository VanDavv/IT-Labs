load data/dane1.txt
dane1 = dane1';

kmeans(dane1, 4)

function result = kmeans(data, clusters)
    net = newc(minmax(data), clusters);
    
    net.trainParam.epochs = 50;
    net = train(net,data);
    result = net.IW{1};
end
