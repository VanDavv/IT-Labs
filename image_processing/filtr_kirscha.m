    clc
clear all; 
close all;

x1 = imread('litery.png'); x = rgb2gray(x1); x = double(x);
%   x = [50,65,112,128;
%       255,91,154,231;
%       234,123,172,195;
%       212,184,156,172];

[row,col] = size(x);
obrazek = zeros(row-2,col-2);

   
for i = 2 : row-1
    for j = 2 : col-1 
        obrazek(i-1,j-1) = zwroc_max(x,i,j);
    end
end

figure(1); 
subplot(1,2,1); imshow(uint8(x)); axis equal;
subplot(1,2,2); imshow(uint8(obrazek)); axis equal;

function [piksel] = zwroc_max(obraz,i,j)
    
    lista = zeros(8);
    lista_a = [obraz(i-1,j-1), obraz(i-1,j),obraz(i-1,j+1),obraz(i,j-1),obraz(i,j+1),obraz(i+1,j-1),obraz(i+1,j),obraz(i+1,j+1)];
   
    for i = 1 : 8
        lista(i) = zwroc_piksel(lista_a,i);
    end
    piksel = max(lista(:));
end
function [piksel] = zwroc_piksel(lista,i)
    indeksy = [mod(i,8),mod(i+1,8),mod(i+2,8),mod(i+3,8),mod(i+4,8),mod(i+5,8),mod(i+6,8),mod(i+7,8)];
    [row,col] = size(indeksy);
    for i = 1 : col
        if indeksy(i) == 0       
            indeksy(i) = 8;
        end
    end
    S = lista(indeksy(1)) + lista(indeksy(2)) + lista(indeksy(3));
    T = lista(indeksy(4)) + lista(indeksy(5)) + lista(indeksy(6)) + lista(indeksy(7)) + lista(indeksy(8));
    piksel = abs(5 * S - 3 * T);
end