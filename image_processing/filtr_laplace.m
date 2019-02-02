clc
clear all; 
close all;

x1 = imread('litery_1.png'); x = rgb2gray(x1); x = double(x);
% x = [1,2,3;
%     4,5,6;
%     7,8,9];
obrazek1 = [x(1,1), x(1,:), x(1,end);x(:,1), x , x(:,end);x(end,1), x(end,:), x(end,end)];
maska1 = [ 0, -1, 0 ; -1, 4, -1 ; 0, -1, 0 ] ;
maska2 = [ -1, -1, -1 ; -1,  8, -1 ; -1, -1, -1 ] ;
maska3 = [ -1, -2, -1 ; -2,  12, -2 ; -1, -2, -1 ] ;
obraz = filtr_laplace(obrazek1,1,maska3);
figure(1); 
subplot(1,2,1); imshow(uint8(x)); axis equal;
subplot(1,2,2); imshow(uint8(obraz)); axis equal;
function [wynik] = filtr_laplace(obrazek,norma,maska)
    
    [row,col] = size(obrazek);
    obrazek2 = zeros(row,col);
   
    for i = 2 : 1 : row-1
        for j = 2 : 1 : col-1 
            obrazek2(i,j) = floor(sum(sum(zwroc_mala_macierz(obrazek,i,j).*maska))/norma); 
        end
    end
    wynik = obrazek2;
end

function [mala_macierz] = zwroc_mala_macierz(macierz,i,j)
    
    mala_macierz = [ macierz(i-1,j-1), macierz(i-1,j), macierz(i-1,j+1);
                    macierz(i,j-1), macierz(i,j), macierz(i,j+1);
                    macierz(i+1,j-1), macierz(i+1,j), macierz(i+1,j+1) ] ;
end

