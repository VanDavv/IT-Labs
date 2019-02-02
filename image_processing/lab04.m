clear all; 
close all;

img = normalize(imread('litery.png'));

img_show(roberts(img), "Roberts", img, "Original");
waitforbuttonpress;

mask = [ 0, -1, 0 ; -1, 4, -1 ; 0, -1, 0 ];
img_show(laplace(img, mask), "Laplace #1", img, "Original");
waitforbuttonpress;

mask = [ -1, -1, -1 ; -1,  8, -1 ; -1, -1, -1 ] ;
img_show(laplace(img, mask), "Laplace #2", img, "Original");
waitforbuttonpress;

mask = [ -1, -2, -1 ; -2,  12, -2 ; -1, -2, -1 ] ;
img_show(laplace(img, mask), "Laplace #3", img, "Original");
waitforbuttonpress;

img_show(sobel(img), "Sobel", img, "Original");
waitforbuttonpress;

mask1 = [-1, 0, 1; -1, 0, 1; -1, 0, 1];
mask2 = [1, 1, 1; 0, 0, 0; -1, -1 -1];
img_show(prewitt(img, mask1, mask2), "Prewitt", img, "Original");
waitforbuttonpress;

img_show(kirsch(img), "Kirsch", img, "Original");
waitforbuttonpress;

clear all; 
close all;

function result = roberts(img)
    result = zeros(size(img, 1), size(img, 2));
    for i = 1:size(img, 1)-1
        for j = 1:size(img, 1)-1
            result(i, j) = floor((abs(img(i,j) - img(i+1,j+1)) + abs(img(i+1,j) - img(i,j+1)))/2);
        end
    end     
end

function result = laplace(img, mask)
    norm = 1;
    result = zeros(size(img, 1), size(img, 2));
    for i = 2:size(img, 1)-1
        for j = 2:size(img, 1)-1
            value = 0;
            for x = -1:1
                for y = -1:1
                    value = value + img(i+x, j+y) * mask(x+2, y+2) / norm;
                end
            end
            result(i, j) = floor(value);
        end
    end     
end

function result = sobel(img)
    result = zeros(size(img, 1), size(img, 2));
    for i = 2:size(img, 1)-1
        for j = 2:size(img, 1)-1
            X = (img(i-1,j+1)+ 2*img(i,j+1) + img(i+1,j+1)) - (img(i-1,j-1) + 2*img(i,j-1) + img(i+1,j-1)); 
            Y = (img(i-1,j-1)+ 2*img(i-1,j) + img(i-1,j+1)) - (img(i+1,j-1) + 2*img(i+1,j) + img(i+1,j+1));
            result(i, j) = floor(sqrt(X^2 + Y^2));
        end
    end     
end

function result = prewitt(img, mask1, mask2)
    result = zeros(size(img, 1), size(img, 2));
    for i = 2:size(img, 1)-1
        for j = 2:size(img, 1)-1
            value1 = 0;
            value2 = 0;
            for x = -1:1
                for y = -1:1
                    value1 = value1 + img(i+x, j+y) * mask1(x+2, y+2);
                    value2 = value2 + img(i+x, j+y) * mask2(x+2, y+2);
                end
            end
            result(i, j) = floor(abs(value1) + abs(value2));
        end
    end     
end

function result = kirsch(img)
    result = zeros(size(img, 1), size(img, 2));
    for i = 2:size(img, 1)-1
        for j = 2:size(img, 1)-1
            pixel = 0;
            negibours = [img(i-1,j-1), img(i-1,j),img(i-1,j+1),img(i,j-1),img(i,j+1),img(i+1,j-1),img(i+1,j),img(i+1,j+1)];
            
            for k = 1:8
                indices = mod(k:k+7, 8);
                indices(indices==0) = 8;
                S = negibours(indices(1)) + negibours(indices(2)) + negibours(indices(3));
                T = negibours(indices(4)) + negibours(indices(5)) + negibours(indices(6)) + negibours(indices(7)) + negibours(indices(8));
                value = abs(5 * S - 3 * T);
                if value > pixel
                    pixel = value;
                end
            end
            result(i-1, j-1) = pixel;
        end
    end     
end

function img_show(img, img_text, raw_img, raw_img_text)
    figure(2);
    subplot(1, 2, 1);
    imshow(uint8(raw_img));
    title(raw_img_text);
    axis equal;
    subplot(1, 2, 2);
    imshow(uint8(img));
    title(img_text);
    axis equal;
end

function img_ = normalize(img)
    img_ = double(rgb2gray(img));
end