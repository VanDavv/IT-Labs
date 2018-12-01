load data/glass_i.txt
we = glass_i';
calc(we, 3, 'glass_9_1_2', [9, 1, 2])

% load data/diabet_i.txt
% we = diabet_i';
% calc(we, 14, 'diabet_1_2_3', [1, 2, 3])

% load data/kapitan_i.txt
% we = kapitan_i';
% calc(we, 3, 'kapitan_i')

% load data/dane3.txt
% we = dane3';
% calc(we, 3, 'dane3')

% load data/dane2.txt
% we = dane2';
% calc(we, 5, 'dane2')

% load data/dane3d1.txt
% we = dane3d1';
% calc(we, 4, 'dane3d1')

% load data/dane3d2.txt
% we = dane3d2';
% calc(we, 5, 'dane3d2')

function calc(we, n, t, idx)
    if ~exist('idx','var')
        idx = [1, 2, 3];
    end
    
    size_we = size(we, 1);
    
    net = newc(minmax(we), n);
    w = net.IW{1}
    if size_we == 2 
        plot(we(1, :), we(2,:), 'b+', w(:,1), w(:, 2), 'go');
        title(t);
        hold on
    elseif size_we == 3
        plot3(we(1,:),we(2,:),we(3,:),'b+',w(:,1),w(:,2),w(:,3),'go');
        title(t);
        hold on
    else
        plot3(we(idx(1),:),we(idx(2),:),we(idx(3),:),'b+',w(:,idx(1)),w(:,idx(2)),w(:,idx(3)),'go');
        title(t);
        hold on
    end
    
    for i=1:20
        net.trainParam.epochs = 1;
        net = train(net, we);

        w = net.IW{1};

        if size_we == 2 
            plot(w(:,1),w(:,2),'ro');
        elseif size_we == 3
            plot3(w(:,1),w(:,2),w(:,3),'ro');
        else
            plot3(w(:,idx(1)),w(:,idx(2)),w(:,idx(3)),'ro');
        end
    end
    nntraintool('close')
    w
    hold off
end