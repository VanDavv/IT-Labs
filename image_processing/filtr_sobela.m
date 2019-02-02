clc
clear all; 
close all;

 x1 = imread('litery_1.png'); x = rgb2gray(x1); x = double(x);
%  x = [50,65,112,128;
%      255,91,154,231;
%      234,123,172,195;
%      212,184,156,172];
[row,col] = size(x);
obrazek = zeros(row-2,col-2);

   
for i = 2 : row-1
    for j = 2 : col-1 
        obrazek(i-1,j-1) = zwroc_piksel(x,i,j);
    end
end

figure(1); 
subplot(1,2,1); imshow(uint8(x)); axis equal;
subplot(1,2,2); imshow(uint8(obrazek)); axis equal;

function [piksel] = zwroc_piksel(obraz,i,j)
        
        X = (obraz(i-1,j+1)+ 2*obraz(i,j+1) + obraz(i+1,j+1)) - (obraz(i-1,j-1) + 2*obraz(i,j-1) + obraz(i+1,j-1)); 
        Y = (obraz(i-1,j-1)+ 2*obraz(i-1,j) + obraz(i-1,j+1)) - (obraz(i+1,j-1) + 2*obraz(i+1,j) + obraz(i+1,j+1));
        piksel = floor(sqrt(X^2 + Y^2));
end
